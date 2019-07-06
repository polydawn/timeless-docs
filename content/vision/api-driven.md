+++
title = "API Driven"
weight = 90
chapter = false
+++

API Driven
==========

- *Communicable results*: the Timeless Stack describes processes in a Formula.
  Communicating a Formula -- via email, gist, pastebin, whatever -- should be enough for anyone to repeat your work.

API-driven design is important for many reasons:

- We need to be able to communicate our products and phases in our production chain;
- We want to be able to stop in the middle of a large sequence of processing and
  have easily serializable snapshots of what's going on for debugging;
- We need those same snapshots for audit purposes in the future;
- and we want other tools and ecosystems to bind easily to our own -- ideally,
  using nothing but some clear core APIs which are serializable using tools
  that are already readymade in any major programming language ecosystem.

We carry this principle at every layer.
For example, Modules are meant to be a serializable construct:
they can be reasoned about statically, and while they *describe* code,
they themselves do *not* require any turing-complete operations to reason about;
and they're representable as simple, regular JSON.
At a layer below, Formulas and RunRecords are the same:
though they *describe* code, they're static and can easily be analyzed without
any need to execute them; and they're simple, regular JSON.

// TODO expand this section
