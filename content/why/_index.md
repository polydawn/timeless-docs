+++
title = "Why"
weight = 19
+++


Why?
====

::info
**about this page:** The "Why?" document outlines the reasons why this project is needed,
why it's important to do it this way, and the essential goals and vision that define our priorities and how we make our choices.

It's a useful document if you're considering whether to get involved, or wondering what kind of efforts are well-aligned.
:::

:::notice
This page is meant to replace and deprecate the "[Vision](/vision)" page, but both are still shown until content migration
and rearrangement is complete.
:::

"Why?" can be addressed at a variety of levels:

- The Mission Statement -- the specific objectives
- The Vision -- *why* we think these things matter
- The Strategy -- the major directions and key technological choices we take to execute this mission and make the vision happen.


Mission
-------

The Timeless Stack is a platform for predictable computing.

We are building tools to match the following criteria:

1. declarative, enumerable dependencies (documents you can read without executing) and clear manageable supply chains
2. hermetic build environments, and other exacting and executable criteria to verify the above,
3. and doing this with a system designed from the ground up with content-addressable elements,
  because this makes many problems solvable without introducing coordination,
  meaning it naturally works well in decentralized environments.

We're doing this because these three design criteria, together, should result in an ecosystem of tooling
that's more composable, more comprehensible, more collaborative, and more experimental-friendly (think: bazaar over cathedral)
than any other possible set of tooling which elides any of these three criteria.

Vision
------

"Vision" describes the highest-level, most abstract goals -- concerning where we want to be,
without regard for how we get there (that's what the [Mission Statement](#mission) is for).

### motivation

Technology needs to be comprehensible.  Computers need to be predictable.

Our whole civilization advances faster when our tools are comprehensible and maintainable.
The integrity of our society relies upon being able to trust the systems we rely
on for our communication, coordination, and increasingly even the control of our physical environment.

Or to flip it around:

Technology should not be enigmatic.  Computers should not house demons.

If they are, we lose control of not just them, but everything we build that depends on them:
eventually culminating in losing control over our societies, our science, and ultimately, ourselves.
Comprehensible technology is not a nice-to-have: it's an evolutionary imperative.

### path

We need reproducible builds to make that happen.

We need hermetic workspace and supply chain management to make that
possible, detectable, auditable, and maintainable.

And we need those things to work well in decentralized environment:
coordination (e.g. in naming and tagging things) should be possible,
but optional rather than required.  This kind of coordination-optional
design is important to enable asynchronous workflows and experimentation,
both of which are important to accelerating technological development
as well as making the tools widely usable.

We need, in short... the things the Timeless Stack [mission](#mission) aims to produce.

### success criteria

We need tools that can build anything, and contain any toolchain. Our solutions should be universal. "Universal" here means not language-specific, and not siloed into a "distro" which requires bidirectional coordination to join.

Our tools should be highly reliable. And every part of them should be clearly able to operate usefully and predictably without live access to the global network.

Our tools should reinforce and encourage and highlight ways for users to make their own things in ways closer to our goals. When some process in our system is non-reproducible, our tooling should detect it, and make it clearly evident to the authoring user, who should in turn feel both empowered and encouraged to fix it.

Our tools should work the same no matter who is using them, when, or where. Minimize presumptions; identify and maintain environments rather than expecting them.

There should be a self reinforcing energy to all of this: we want tools that work better when building reproducible things, and make it clearly evident the authoring user when reproducibility has been lost. The effect of this should be to make it clear that reproducibility provides value, make the feedback loops more obvious, and orient and draw attention to those feedback loops such that users self-correct and improve their own systems over time.

Strategy
--------

### familiar tools

Specifically, the primary target and scope can be summarized as “must support linux-like systems” and “must pass state primarily by familiar ‘file’-like abstractions”.
(In other words -- “it should taste like containers” -- this is a proven path to successful adoption that lets others use what they know and pivot towards our tooling incrementally.  Incremental is good.)
This scope may extend to more systems in the future, but will start here.

### anything not everything

The Timeless Stack tools need to support *anything* -- anything you want to put in them, with no special consideration required -- rather than supporting "everything", but needing plugins to do it.  This stands in contrast to most other build tools.

### breaking down the problem

There are five major sets of problems that need to be addressed:

1. Framing and hermetic execution and fileset-slinging core
2. Coordination systems for connecting graphs of executions and outputs -- both for authoring graphs of intent, and then precipitating graphs of actual outcome (which can be repeated).
3. Extended Coordination: these systems need to work for both directly-communicating people (e.g. projects and close-knit teams -- easy) and at large (e.g. uncoordinated swarms of projects at scale on github, etc -- harder!) without compromising on the Timeless philosophy.
4. Responsible Packaging -- community standards for how to prepare software to work well with immutable systems and minimal environment presumptions
5. Last-mile applications... such as CI, new "app stores", etc -- given the platform core, building these should become near-trivial!

Some of these are easier than others, e.g. Part 1 can be done nearly off-the-shelf with existing components.
Part 2 is something that simply needs doing.
Part 3 is pretty much a leading edge research problem in distributed workflow UX, but we're doing it anyway because it needs to be done.
Part 4 is a community standard thing rather than plain code, so either easier or harder depending on your point of view.
Part 5 is actually quite open-ended, and we expect to see lots of independent projects flourish there!

The most important thing is to identify and isolate these problems;
in identifying their scope, we make them tractable.

### composable tools

Each of the layers of problems should be solved by its own tooling.

These tools should work well together, but also be usable independently.

See the [Tools Reference](/tools) pages for an index of each of the separate tools we currently develop.

### API and checkpoint driven

Each of our tools should work declaratively, be easily driven by APIs (not just CLIs and sloppy glue),
and be "checkpoint driven" -- which means the data passed between the APIs should be possible to serialize,
and -- at that instant -- inspect it, save it, repeat it, shift it to another machine, whatever.
*Code* should not be passed between processes; documents should.

"API" should mean simple common formats -- JSON piped to `stdin` and JSON streamed to `stdout` is a solid API.

See the [design/layers](/design/layers/) page for more about our API layers.

### hash all the things

One key theme we'll find recur overall in the tactics so often that it might as well be called strategy:
**we're going to hash _everything_.**
Hashes let us build content-addressable systems, which work well in decentralized systems;
hashes give us ways to dodge naming problems which would otherwise introduce coordination issues, which makes interoperability easier even for people working independently;
and hashes create quick ways to detect if data is identical at massive scales, which is critical to reproducibility detection.
Since all three of these properties are so critically useful, executing strategic design with a "hashes first" philosophy gives the Timeless Stack a distinct style -- and a distinct advantage.


Tactics
-------

Tactics are reducing strategy to action.

For us, "tactics" are "tools".

- the `rio` tool provides content addressable file warehousing, using any of a variety of mechanisms, so long as they work by hash.
- the "formulas" specification provides a way to describe (and hash) a computation we want to explore.
- the "runrecords" specificaion provides a way to describe (and hash) the *results* of a formula.
- the `repeatr` tool provides hermetic isolation for executing other tools -- following a "formula", and reporting a "runrecord"! -- using containers to deliver it.
- the "modules" specification provides a way to describe graphs of computations, which pass data between them in discrete steps -- this enables larger scale work than formulas alone.
- the `reach` tool provides a way to execute modules easily.
- the "catalog" specifications, combined with standards for "replayable modules", establishes just enough standards for name->hash mappings to make them sharable -- while leaving just enough explicitly *unanswered* to spur the evolution of a clear separation between metadata circulation and version selection problems.
- the `reach` tool also bundles features for authoring catalogs -- both updating the name->hash mappings, attaching replay instructions to those, and sharing the whole thing with others.
- in ecosystem standards, the emphasis on non-turing-complete tools for templating and manipulating catalogs and modules results in a more inspectable and analyzable ecosystem even as it increases in size and scale and number of uncoordinated authors.

You can read more about these things in the rest of the site.

Some of these tools are complete!  Some of them are less complete.
All of them are prototypes, and if in experimenting with them, we find that
they don't sufficiently fit the mission, we can replace them.

Contributors to all these things are welcome!
