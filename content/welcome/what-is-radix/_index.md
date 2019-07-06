+++
title = "What is Radix?"
weight = 20
+++

Radix
=====

> Radix  
> 1 : the base of a number system or of logarithms  
> 2 : the primary source

*(We're going with definition 2, here.)*

Radix is a project to build software reproducibly
using [Repeatr](https://github.com/polydawn/repeatr),
[Reach](https://github.com/polydawn/reach),
and the [Timeless Stack](https://github.com/polydawn/timeless).

Radix "Packages" are similar to packages from other linux distributions...
however, we're aiming to do something *not* like linux distributions:
our vision for Radix Packages is that they go *anywhere*, with *or without*
the rest of a distro associated with them.

### Responsible Packaging

A key part of the Radix project is to specify patterns and guidelines for
software packaging and distribution which make the world simpler.

We already have a lot of "hard" problems *solved* by building on top of
the Timeless Stack -- we have hermetic builds; we have snapshottable indices;
we have immutable distribution systems; and so on.

So what's left?  The contents of the packages themselves, of course!
Here are some attributes we'd like to ensure:

- all dependencies are from in the Timeless Stack; no unclean network fetches;
- the build is reproducible;
- the runtime dependencies are either bundled or clear (hash-linked);
- the product fileset is path-agnostic;
- when using shared libraries, any libraries are co-installable;
- the choice between packaging with shared libraries or using omnibus bundles
  should be a trivial choice (and not require recompilation!);
- post-install hooks are not permissible.

### Alpha Notice

Radix is an early stage project.  As such, the documentation stops here.
Get in touch if you'd like to contribute :)
