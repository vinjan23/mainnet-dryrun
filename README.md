# Mainnet Dryrun 1

This repository will be used to do a mainnet dryrun process

## Process

1. Coordinator asks validators to provide a ARCH address, which then will be used to generate initial genesis file
1. Coordinator provides validator the initial genesis file (init_genesis.json) and then asks validators to create their `gentx`
1. Validators create a PR to this repository. That PR must include:
    1. `gentx` json file with the default generated filename put inside the `gentx` folder (Validator must not modify the name of the generated gentx file).
1. When all Gentx files have been collected, Coordinator creates the final `genesis` file
1. Coordinator uploads the final genesis file to this repository under the `genesis` folder
1. Coordinator starts their nodes and provides a list of `seed` & `persistent peers` that Validators will use to configure their servers.
1. Validators can then start their nodes in coordinated fashion after Coordinator gives a go ahead.

## Configuration

|Name   | Value   | Description  |
|---|---|---|
| ChainID   | archway-dry-run-1   | Name of the chain that will be used   |
| Persistent Peers   | TBA   | Persistent peers to be configured   |
| Seed node   | TBA   | Seed nodes to be configured   |
