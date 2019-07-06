+++
title = "Hello Rio"
weight = 36
+++

Hello Rio
=========

In this getting started doc, we'll show working examples
of using Rio to pack and unpack files and derive WareIDs from them.

You should be able to copy the snippets in this file directly,
and they should work without modification.
You should be able to modify them afterwards to build in the
directions you wish to explore.


Packing and unpacking Wares
---------------------------

Once you have things packed into wares and identified by WareIDs, it's easy to assemble them and also build new ones with Repeatr.
But what about at the edges of the system?
How do we import new stuff from the outside world?
How do we export stuff we make to other folks?

The answers all these questions are pretty simple: [`rio`](/tools/rio).
You can use `rio --help` to get an overview of everything Rio can do;
in short, it's for moving packed Wares around and for shuffling files in and out of packed form.
`rio` was what `repeatr` used earlier to get and save your files; if you watch
`ps` while it's running, you'll see a `rio` child process for every input and output.
We can also use `rio` directly ourselves!

### Packing files into wares

`rio pack <packtype> <filesetPath> [--target=<warehouseURL> ...]`

Packing turns a fileset -- any ol' directory full of files -- into a packed form,
and if a target warehouse is specified, uploads the packed data there.

This command returns a WareID on stdout.  You can easily pipe this to other
commands (like `rio unpack` to simply get the same files back again), or
template it into a formula's input section.

### Unpacking wares into files

`rio unpack <wareID> <destinationPath> [--source=<warehouseURL> ...]`

(Note that `<wareID>` looks like `<packtype>:<hash>` -- they're the same thing.)

Unpacking fetches data based on its wareID -- a content-addressible identifier,
based on cryptographic hash, which means what you get is immutable and always
exactly what you asked for -- and unpacks it into a fileset on a local directory.

Unpacking, like packing, prints a WareID on stdout when done.  Depending on your
other flags, this may be a different WareID than the one you asked for!
`rio unpack` will unpack the files with your current user's UID and GID by default;
doing so results in a slightly different filesystem, and that's what this resulting
WareID is describing.  Check out the `rio unpack --help` for more info on these
flags (particularly, `--uid`, `--gid`, and `--sticky`.)

You will need to start `rio` with superuser privileges to successfully perform
a `rio unpack` with UID and GID settings (as usual -- no magic here).

### Scanning existing packs for WareIDs

`rio scan <packtype> --source=<singleItemWarehouseURL>`

Rio can scan existing packed data and report the WareID.
This only makes sense for some pack types:
for example, it's easy to do this with tar archives produced by other processes...
but doesn't really make sense to do with git repositories,
because there's no such thing as identifying git repo content *without* a hash
(so to turn a git hash into a WareID, you just prefix `"git:"` to the string!).

The `--source` argument uses the same style of warehouse URLs as all Rio subcommands,
but interprets it slightly differently: the URL must identify *one* ware only.
For example, you can use `ca+file:///.warehouse/` in `rio pack` and `rio unpack`,
but you *cannot* use that URL with `rio scan`; you'll have to drop to a non-CA
variant so that a specific ware is pointed to rather than a whole warehouse.
