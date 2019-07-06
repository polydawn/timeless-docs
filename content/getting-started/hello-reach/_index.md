+++
title = "Hello Reach"
weight = 37
aliases = [
	"/getting-started/hello-stellar/"
]
+++


Hello Reach
===========

In this getting started doc, we'll show working examples
of using Reach to execute a group of Repeatr and Rio processes.

Reach lets you build pipelines of computations, connecting a series
of steps by giving names to the [Wares](/glossary#ware) that should be passed between them;
these steps get templated out into Repeatr [Formulas](/glossary#formula)
and each run in dependency order.


Demo Repo
---------

https://github.com/polydawn/stellar-demo

The following sequence of commands should demonstrate some action:

```
git clone https://github.com/polydawn/reach-demo
cd reach-demo
reach emerge
```

The result should be a quick run of a reach demo.

- This demo just runs one step,
- getting some inputs from a Reach [Catalog](/glossary#catalog),
- gets another input from "ingesting" it from the surrounding git repo,
- and runs a formula.

Some of the interesting properties of the system to highlight here:

- The human-readable names used in the [Module Import](/glossary#module-import)
  are supplied by the files in the `.timeless/catalog` path.
  (You can see these on github here: [reach-demo//.timeless/catalog/.../lineage.tl](https://github.com/polydawn/reach-demo/blob/master/.timeless/catalog/early.polydawn.io/monolith/busybash/lineage.tl))
  This means the name resolution is [reproducible](/vision/reproducible-resolve).

However, we also used another interesting feature which shakes things up a bit:

- Since this uses a git ingest for one of the imports, this is *not* a "[replayable](/design/catalogs#replays) Module".
  - ... but it could be *transformed* into one, simply by rewriting that ingest
    into some other kind of import such as another catalog reference!


Help us Improve
---------------

This document is currently a little terse :)

PRs to improve documentation are very welcome :)
