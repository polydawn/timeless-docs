+++
title = "Glossary"
weight = 100
pre = "<b>#</b> "
+++

Glossary
========

<style>
h3 {
	display: inline;
	font-family: "Work Sans", "Helvetica", "Tahoma", "Geneva", "Arial", sans-serif;
	font-weight: 300;
	color: #720 !important;
}
h3:not(:first-of-type):before {
	content: " ";
	display: block;
	border: 1px solid #EEE;
	margin: 1em 0;
}
h3:after {
	content: ":";
	padding: 0;
	border: 0;
	margin: 0 0.5ex 0 -0.2em;
}
h3 + p {
	display: inline;
	font-family: "Work Sans", "Helvetica", "Tahoma", "Geneva", "Arial", sans-serif;
	font-size: 1.2rem;
}
</style>

### Catalog

Catalogs are a system for associating human-readable names with [WareIDs](#wareid).

See the [Catalog Design](/design/catalogs) for extended description.

### Fileset

A set of files and directories, including standard posix metadata.  Nothing special :)

When "packed", a fileset becomes a [Ware](#ware).

We use this term primarily to disambiguate what a Fileset is versus any details of its
packing and transport.  A good analogy is tarballs and torrents: both tar files
and torrents might be considered a way of packing and distributing a [Ware](#ware),
but both of them can contain an identical Fileset.

Filesets can be packed and unpacked by the [Rio](/tools/rio) tool.

### Formula

A complete definition of a computation.
Pins all input [filesets](#fileset) by [WareID](#wareid).
Formulas are evaluated in a sandbox.
The result of evaluating a Formula is a [RunRecord](#runrecord).

See the [Layer 1 Schema](/schema/layer-1) docs for extended description,
and the [Repeatr](/tools/repeatr) tool for how to execute them.

### Formula Action

A script to run inside the container when evaluating a [Formula](#formula).

See the [Layer 1 Schema](/schema/layer-1) docs for extended description,
and the [Repeatr](/tools/repeatr) tool for how to execute them.

### Formula Inputs

A group of [WareIDs](#wareid) and where to mount them in a directory tree
when setting up the environment to evaluate a [Formula](#formula).

Together with the [Formula Action](#formula-action), the Inputs provide
a [Hermetic](/vision/strategy/hermetic-computation) description of a computation.

### Formula Output

A list of paths to save when the Formula's [Action](#formula-action) is complete.
Files under an output path will be exported as a [Ware](#ware),
and when the run is complete, the resulting [WareIDs](#wareid) are reported
in the [RunRecord](#runrecord).

### Lineage

A lineage is the collected, ordered set of releases for some module.

A lineage is composed of references to [Release Records](#releaserecord).

Linages exist at [Layer 2](/schema/layer-2) of the API,
with the other [Catalog](#catalog) concepts,
and are evaluted by the [Reach](/tools/reach) tool.

### Module

A graph (a DAG) describing a series of proto-[Formulas](#formula), specifying
human readable names (scoped locally to the Module, or, using
[Catalogs](#catalog) to connect to a bigger picture);
these human readable names will then later be resolved into [WareIDs](#wareid).

Each [Step](#module-step) in the Module will be resolved to one [Formula](#formula)
(using some name resolution process), which can then be evaluated, and then its
outputs can be used as inputs in other steps.

Modules exist at [Layer 2](/schema/layer-2) of the API,
and are evaluted by the [Reach](/tools/reach) tool.

### Module Import

TODO

### Module Export

TODO

### Module Step

TODO

### Packtype

Packtype refers to the format of a packed [Ware](#ware).
It's the first segment of a [WareID](#wareid).

### ReleaseRecord

TODO

### RunRecord

The result of evaluting a [Formula](#formula).
Includes the `exitcode`, a 'results' map full of [WareIDs](#wareid) corresponding
to the [Formula Outputs](#formula-output), and also metadata like `timestamp`.

Note that while [Formulas](#formula) are designed to converge, RunRecords are
the *opposite*: inclusion of nondeterministic fields like the `timestamp` is
intentionally used to make RunRecords *not* deduplicate.
This is useful because we may want to explicitly record the fact that a
Formula evaluation produced the same *results* at several different *times*.

RunRecords exist at [Layer 1](/schema/layer-1) of the API,
and are produced by [Repeatr](/tools/repeatr) when it evaluates a [Formula](#formula).

### Ware

The "packed" form of a [Fileset](#fileset).
Tarballs, zips, git commits; many formats are defined.
Wares are immutable and can be refered to by [WareID](#wareid).

Wares can be packed and unpacked by the [Rio](/tools/rio) tool.

### WareID

A short string identifying a Ware, composed of a [Packtype](#packtype)
and a **hash**.
Holding a WareID gives you an immutable reference to a [Ware](#ware),
which you can unpack into a [Fileset](#fileset).

WareID tuples look like "`{packtype}:{hash}`", delimited by a colon -- for example,
"`tar:6q7G4hWr283FpTa5Lf8heVqw9t97b5VoMU6AGszuBYAz9EzQdeHVFAou7c4W9vFcQ6`",
or "`git:c0d6989e1d1031a2760b8b0bfe163d75eae05e07`".

WareIDs exist at [Layer 0](/schema/layer-0) of the API,
and are the inputs and outputs of the [Rio](/tools/rio) tool.
