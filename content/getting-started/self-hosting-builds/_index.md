+++
title = "Self-hosted builds"
weight = 40
+++

Builder, Build Thyself
======================

The Timeless Stack can be used to build the Timeless Stack.
This is actually how we build our releases!
And, it's also a pretty good demo.

There are two different builds:

### Building via bash

Check out [this example](https://github.com/polydawn/timeless/blob/master/omnibus/build.sh).

This script builds each of the timeless stack components in its own formula,
and then runs one final formula to gather all the pieces together into the
single tarball (which we then release).

This bash script depends on `rio`, `repeatr`, `refmt`, and `jq` being on your `$PATH`.
All of the initial inputs are declared as bash environment variables, and
then simply substituted in using bash heredocs as a form of templating.
Intermediate outputs are then passed around using `jq` to extract the
[WareID](/glossary#wareid)s from each run's [RunRecord](/glossary#runrecord),
and templated back into subsequent [Formulas](/glossary#formula) via
another bash environment variable.

Compared to the build with Reach (below), this script is hacky.
It's turing complete; it's running code on the host; and it's a very
simple thing manually written with hardcoded order of events.
The build with Reach is better in almost every way!
But, the bash script is interesting as an example of how the system
is API-driven, and hopefully is thereby educational to read.

### Building via Reach

Check out [this example](https://github.com/polydawn/timeless/blob/master/omnibus/module.tl).

This [Module](/glossary#module) file can be evaluated by the [`reach`](/tools/reach) tool.
It describes a *graph* of build steps,
passing intermediate outputs by human-readable names that are locally scoped.

Rather than having the input [WareID](/glossary#wareid)s hardcoded,
this module file refers to ["Catalog"](/glossary#catalog) [imports](/glossary#module-import):
these are stored in the neighboring `.timeless/catalog` directory.
(These catalog files are relevant when coordinating the passage of
WareID info between even larger groups of projects in an auditable way.)

The order of events (the dependency topology) is the same as the bash build!
However, the order will be determined automatically by the `reach` tool.

Contrasted with the bash build, the Reach-powered build can be reasoned
about completely statically.  There is no turing-complete logic running
on the host in order to evaluate the build dependencies!

### Reproducible!

Both the bash-powered and Reach-module builds *should produce identical results*.

You should also be able to use `rio scan` on the binary releases from GitHub
and *also* get an identical hash!
