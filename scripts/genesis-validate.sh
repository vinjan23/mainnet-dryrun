#!/bin/bash
set -xeuv

# Archway default test configuration
# Command
ARCHD="./archwayd"
# Operating Directory
ARCHDIR=".archway"
GENTX_FILE=$1

# Timeout
TIMEOUT="60s"

# Required fee
REQ_FEE="180000000000000000"

# copy initial genesis
mkdir -p $ARCHDIR/config/gentx
cp init_genesis.json $ARCHDIR/config/genesis.json

# check that GENTX_FILE is not empty
if [ -z "$GENTX_FILE" ]; then
    echo "GENTX_FILE is empty"
    exit 1
fi

# check that gentx is valid
cp "$GENTX_FILE" $ARCHDIR/config/gentx/

# check that gentx fee value is equal to required fee value
GENTX_FEE=$(jq -r '.auth_info.fee.amount[0].amount' "$GENTX_FILE")
if [ "$GENTX_FEE" == null ]; then
    echo "Gentx fee is empty"
    exit 1
fi 
if [ "$GENTX_FEE" -lt "$REQ_FEE" ]; then
    echo "Gentx fee is less than minimum required fee: $GENTX_FEE / $REQ_FEE"
    exit 1
fi


# collect gentx
$ARCHD collect-gentxs --home $ARCHDIR

# validate genesis
$ARCHD validate-genesis --home $ARCHDIR

# start node and shut it down after timeout
$ARCHD start --home $ARCHDIR 2>&1 | tee -a err &
sleep $TIMEOUT
kill $(pgrep archwayd)

# check for panics
if  grep panic err; then
  echo "Panic found in log"
    exit 1
fi
