#!/bin/bash
set -xeuv

# Archway default test configuration
# Command
ARCHD="./archwayd"
# Operating Directory
ARCHDIR=".archway"
GENTX_FILE=$1

# Timeout
TIMEOUT="50s"

# copy initial genesis
mkdir -p $ARCHDIR/config/gentx
cp initial-genesis.json $ARCHDIR/config/genesis.json

# check that GENTX_FILE is not empty
if [ -z "$GENTX_FILE" ]; then
    echo "GENTX_FILE is empty"
    exit 1
fi

# check that gentx is valid
cp "$GENTX_FILE" $ARCHDIR/config/gentx/

# Extract data from provided gentx
# Here we can run additional validation,
# such as checking for a valid security_contact;
# ADDRESS=$(jq -r '.body.messages[0].delegator_address' $ARCHDIR/config/"$GENTX_FILE")
# echo "address: $ADDRESS"
# VALUE=$(jq -r '.body.messages[0].value.amount' $ARCHDIR/config/"$GENTX_FILE")
# echo "$VALUE"
# GENESIS_VALUE=$(jq -r ".app_state.bank.balances[] |select(.address==\"$ADDRESS\") | .coins[0].amount" "$ARCHDIR/config/genesis.json")

# collect gentx
$ARCHD collect-gentxs --home $ARCHDIR

# validate genesis
$ARCHD validate-genesis --home $ARCHDIR

# start node
if timeout $TIMEOUT $ARCHD start --home $ARCHDIR| grep panic; then
    exit 1
fi
