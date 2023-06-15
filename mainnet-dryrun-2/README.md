# Mainnet Dryrun 2

This repository will be used to do a mainnet dryrun process

## Process

1. Coordinator asks validators to provide a ARCH address, which then will be used to generate initial genesis file
1. Coordinator provides validator the initial genesis file (init_genesis.json) and then asks validators to create their `gentx`
1. Validators create a PR to this repository. That PR must include:
   1. `gentx` json file with the default generated filename put inside the `mainnet-dryrun-2/gentx` folder (Validator must not modify the name of the generated gentx file).
1. When all Gentx files have been collected, Coordinator creates the final `genesis` file
1. Coordinator uploads the final genesis file to this repository under the `mainnet-dryrun-2/genesis` folder
1. Coordinator starts their nodes and provides a list of `seed` & `persistent peers` that Validators will use to configure their servers.
1. Validators can then start their nodes in coordinated fashion after Coordinator gives a go ahead.

## Documentation

More information how to become a validator can be found from Archway's documentation <https://docs.archway.io/validators/becoming-a-validator/overview>

## Configuration

| Name      | Value                                                         | Description                         |
| --------- | ------------------------------------------------------------- | ----------------------------------- |
| ChainID   | mainnet-dry-run-2                                             | Name of the chain that will be used |
| Seed node | e4669ea649f8ece90fe340136f853a015f81d1c5@34.133.237.198:26656 | Seed nodes to be configured         |
