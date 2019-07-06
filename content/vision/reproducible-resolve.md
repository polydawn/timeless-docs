+++
title = "Reproducible Resolve"
weight = 30
+++

Reproducible Resolve
====================

### What is "resolve"?

"Resolve" can mean two things:

- Translating names and version numbers into a [WareID](/glossary#wareid)
  (in essence, translating a mutable reference to an immutable hash);
- Resolving imprecise version range specifiers or transitive dependencies
  into a specific version name.

In any system which uses human-readable names, or in any system which has
a concept of "updates", we'll end up with a concept of "resolve".

Of course, in the Timeless Stack, this is a touchy subject for us.
We just got done describing the ["Immutable Everything"](../immutable-everything)
principle in the preceding page!

How do we reconcile the need for naming and updates with immutablity
and timeless explainablity and our other goals?

### What is "reproducible resolve"?

The key here is simply to identify "resolve" as an operation itself,
and hold that computation to as high a standard as everything else.
*Of course* the Resolve operation has to be reproducible.

So, it follows naturally that *of course* the Resolve operation must be
handled using [Hermetic Computation](../hermetic-computation).

And thence it follows naturally that *of course* we'll need an atomic
snapshot of all of the inputs to the Resolve operation.

So: Reproducible Resolve is what happens when you take your resolve operation,
have a clear mechanisms for hermetic evaluation of it, and a defined pathway
for distributing snapshots of the data that resolve needs as inputs.

In the Timeless Stack, our main data structure for this is called a
"Catalog": you can read more about them in:

- [Catalog in the glossary](/glossary#catalog)
- [Catalog in the design docs](/design/catalogs)
- [Catalog in the schema reference](/schema/layer-2/#catalog)

The key concept of the Timeless Catalog is that it supplies a *whole system* snapshot:
When we perform Resolve operations in the Timeless Stack tools
-- both the "version range to specific version" as well as the "name to hash" kind --
*all* the metadata and *all* the inputs for Resolve processes must come from a Catalog.
That Catalog used as the input to Resolve is is carefully defined to be snapshottable
as well as easy to replicate, and it's even possible to address it as a WareID.
This makes Reproducible Resolve possible, and makes Timeless Stack tools reliable
and predictable even when working with the normally-touchy subject of updates.

### Why is this important?

Reproducible Resolve is part of the "Reproducible by Design"/"un-degrading" vision
and the "Decentralized" goals.

Systems without reproducible resolve tend to be difficult to explain the state
of at any date other than the immediate moment they were "updated".

*With* reproducible resolve, we can always backtrack to the catalog snapshot
we used during our last update: and using that snapshot, we can re-evaluate
our resolve logic, watch what it does, and have a complete understanding of
why our resolved system is in the state that it is.

### Better updating

A system built around Reproducible Resolve naturally ends up with a very nice
user experience during "updates": users can fetch new information
(a new Catalog, if you will), and then see what this information might
recommend they do with their system; and *then* decide whether they want to
make those changes or not.

Reproducible Resolve naturally makes for a very highly controllable process.

### (Could we have skipped this whole thing by avoiding names in the first place?)

Yes... but also no.

It's true that if you model the universe as a set of functions
(functions for build; functions for compose system, etc), and
you apply function composition a la `f(a(b(), c(d(), e()))`,
and all the function names are actually the operators themselves...
then you can construct an awful lot of things without ever using names.

And to some extent, we can certainly do this in the Timeless Stack as well.

However, this model tends not to permit "updates" in a way that's very satisfying.
Given such a tree of functions, it's awfully hard to create clearly
documented relationships where one version of a function might be newer and
a preferred replacement to another.  And if you're in some sort of
["monorepo"](https://en.wikipedia.org/wiki/Monorepo) situation, maybe this is fine;
but if you're in a distributed mindset, and you want to be able to communicate
the concept of changes over time to *other people*... this anonymous functions
model just doesn't do it.

In short: introducing naming to the system is key to the "Decentralized" goal.

For more about how we compose naming with our reproducibility goals,
check out the [Design chapter on Catalogs](/design/catalogs/).
