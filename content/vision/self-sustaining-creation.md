+++
title = "Self-sustaining Creation"
weight = 40
+++

Self-sustaining Creation
========================

> *Alternate title: "Closing the Loop"*

The Timeless Stack is about making reliable systems.
To do this effectively,
it's important not only to take existing systems and freeze them in amber:
it's important to encourage *producing new things* which are reliable by design.

This is a point that's weird to drive home, because it seems almost too obvious.
Of *course* we want to produce new things in the system itself.
But consider how many systems don't do this (and how they shape out over time):

- Docker tends to be a wrapper that snapshots the products of another package manager -- or two!
  Typically we see either Debian's `apt` or Alpine's `apk`...
  plus a language package manager, such as Node's `npm` or PHP's `composer`, etc.
  The precise package managers don't matter: they all have the same flow:
  they perform some network operations to get the list of packages,
  select some packages, and then do some operations to "install" those packages.

What does this yield?  An unreproducible mess, generally speaking.

Such a build process may produce snapshottable artifacts, and this does make
deployment of those artifacts easier since the artifacts are complete...
but the builds aren't reproducible; they're not reliably; they're not auditable...
we're not all that much better off than we were before the snapshotting system
entered the story.

And does any of it help produce *new things* that are made more reliable
by any of the investments in tooling or existing snapshots?  No.

So, it's clear that in the Timeless Stack we need to do something different.
We need to produce something that's composable: something that's good at
integrating into and supporting the flow of creation, not just of packaging
final artifacts.

// TODO this page may better belong under the "Philosophy" chapter.
