+++
title = "Tools: Rio"
menuTitle = "Rio"
weight = 10
+++

# Rio

```
usage: rio [<flags>] <command> [<args> ...]

Repeatable I/O.

Flags:
  -h, --help         Show context-sensitive help (also try --help-long and --help-man).
      --format=dumb  Output api format

Commands:
  help [<command>...]
    Show help.

  pack [<flags>] <pack> <path>
    Pack a Fileset into a Ware.

  unpack [<flags>] <ware> <path>
    Unpack a Ware into a Fileset on your local filesystem.

  scan [<flags>] <pack>
    Scan some existing data stream see if it's a known packed format, and compute its WareID if so. (Mostly used for importing tars from the interweb.)

  mirror [<flags>] <ware>
    Store already-packed wares in one warehouse, copying from other warehouses.


```
