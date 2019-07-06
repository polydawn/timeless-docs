+++
title = "Installing"
weight = 10
+++

Installing the Timeless Stack
=============================


Projects
--------

The Timeless Stack is composed of several components,
each with its own source repo:

|  Tool       |  Repo                                           |  Role      |
|:-----------:|:-----------------------------------------------:|:-----------|
| `rio`       | [github](https://github.com/polydawn/rio)       |  R-I/O stands for Repeatable Input/Output: it's tooling for packing Filesets into Wares, mirroring Wares between storage systems, and unpacking Filesets fetched by WareID.  Glue for getting files to and from other systems, in other words.
| `repeatr`   | [github](https://github.com/polydawn/repeatr)   |  Repeatr evaluates formulas.  `formula`⟶`repeatr run`⟶`runrecord`
| `reach`   | [github](https://github.com/polydawn/reach)   |  Reach builds larger pipelines: use it to stich together several formulas by passing wares between them.  Entire pipelines quickly rebuild incrementally, automatically memoizing any steps that haven't changed.
| these docs! | [github](https://github.com/polydawn/timeless)  |  This documentation is open-source and patches welcome :)

You can check out each of these repos independently.
Each repo maps to one [tool](/tools);
each tool maps to one of the [design layers](/design/layers).

You can build each of these projects from source individually,
and put the resulting binaries on your $PATH.

For the most part, however, we bundle all of these together and ship them as a unit for other users:
we call this aggregate the Timeless Stack "omnibus" release.


Installing the Omnibus
----------------------

"Omnibus" releases contain all of the pre-built `rio`, `repeatr`, and `reach` commands.

They are available for download from the releases page of the github project:
https://github.com/polydawn/timeless/releases .

You can unpack this tarball anywhere you want.
All of the bundled binaries are statically linked, and should run on any system,
as long as you've selected an OS/architecture that's runnable on your host.


### rebuilding the omnibus

(If you just want to get started, skip this section.)

If you're interested in how the omnibus is built, look to the source:

https://github.com/polydawn/timeless/tree/master/omnibus

The omnibus is actually built in two independent paths, each of which produces identical results:

- the `module.tl` file in that dir can be evaluated by `reach emerge`;
- the `build.sh` file in that dir can be evaluated by plain bash.

It's the result of these builds that is uploaded to the github releases page.
You should be able to reproduce the release binaries identically by using either of these processes!
