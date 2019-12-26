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

### breaking down the problem

### composable tools

### API and checkpoint driven

### hash all the things
