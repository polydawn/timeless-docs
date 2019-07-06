+++
title = "Layer 2 (Pipeline)"
weight = 20
+++

Layer 2 Schema
==============

Layer 2 of the design describes how to build pipelines of computations, and
provides a schema for publishing snapshots of previous computation results,
associating them with human readable names for lookup, and attaching complete
instructions for running those pipelines again.

(Refer to the [Design chapter](/design) if further contextualization is required.)

Schema
------

The key concepts at Layer 2 are the `Module` and the `Catalog`.
Modules are about computing new stuff;
Catalogs are about how we reference stuff we've computed before,
and how we pass those reference around and share them with other people.

### Modules

```ipldsch
{{% readfile file="schema.ipldsch" %}}
```

Note that `Operation` is basically isomorphic to `Formula` at Layer 1:
it just uses `SlotRef` and `SlotName` -- human-readable labels -- instead
of going straight to `WareID`s.
These labels allow us to describe a graph of computation, without yet
having actually evaluated any of the concrete values.

`Module` is just a big group of `Operation`s wired up together.
(They can be defined recursively, too, but that's just syntactic sugar;
you don't need to use this feature unless you find it helpful for
scoping and namespacing in a really large project.)

Some of the types from Layer 1 -- like `RunRecord` -- don't show up
again *explicitly* in Layer 2... but they're still in the background.
Imagine that when you evaluate a `Module`, it's precipitating out
`Formula`s and `RunRecord`s as the computation proceeds.

Similarly, types from Layer 0 -- like `WareID` -- don't show up *explicitly*
in Modules in Layer 2... but like `Formula` and `RunRecord`, they're produced
as a consequence of evaluating a `Module`: the final product of evaluating
a module is a map of `{ItemName:WareID}`!
Catalogs (which we'll discuss more in a moment) also make heavy use of `WareID`.

### Catalogs

```
// TODO
```


Modules vs Replayable Modules
-----------------------------

Modules can be considered to have two different flavors: "replayable", or... not.

The difference comes down to what kinds of `ImportRef` have been used in the
module's imports.
Certain kinds of imports -- namely, the `"catalog"` kind -- are things we can
expect to [*reproducibly resolve*](/vision/strategy/reproducible-resolve).
A module that uses *only* these imports is something that we thus expect to
be able to run again -- "replay", if you will -- at any time, even in the
distant future, or without much of the ambient context of our current environment.

Remember that we can also have imports of the `"ingest"` kind.
Ingest imports are a mechanism for bringing new data into the Timeless ecosystem.
Ingest imports handle un-contained un-tracked content!  Though ingests turn
such data *into* `WareID`s and thus tracked content... the ingest itself
needs the un-contained context to do that.  So, ingests are *not* easily
replayable without that context.

Fortunately, we can make an unreplayable module -- one that uses "ingest"
imports -- into a replayable one.  It's easy: all we have to do is turn any
of the "ingest" imports into "catalog" imports instead.

This conversion to a replayable module can even be automatic: for example,
if a module has an ingest import, and uses a SlotRef in its exports which
refers directly to that ingest: then, when making releases out of this module,
we can automatically re-write the import to refer to a catalog... *the one
we're making a release into right at that moment*.

Writing modules using "ingest" imports is great for productivity.
Replayable modules are great for the timeless ability to recompute things.
Automatic rewrite of modules into replayable form is a tool we use
to get the best of both worlds.
