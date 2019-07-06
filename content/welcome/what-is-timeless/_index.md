+++
title = "What is the Timeless Stack?"
weight = 10
+++

The Timeless Stack
==================

The Timeless Stack is an ecosystem of tools and standards for doing computation
(in general) and building and distributing software (in particular).

The name expresses the primary goal: Timeless Stack tooling is focused on
making sure any process that worked once will work again, reliably --
3 days from now; 3 weeks; 3 years; or 300.
(You can read more about this in the [Vision chapter](../../vision).)

To reach this goal of reliability, the Timeless Stack builds everything
around snapshots, immutable data, and reproducible transformations.

To do this, the Timeless Stack encompasses...

- **handling snapshots of files**
- **building software** in containers
- **publishing releases** that associate names and metadata to filesets snapshots
- and **distributing packages** of filesets that assemble into useful systems!

It's a lot of responsibilities.  We've broken them up into several tools.  Use the parts you need.  Ditch the ones you don't.  Each tool is API-driven and can be used in isolation, or glues together easily with the others.

You can read more about the various API layers in the [Design chapter](../../design),
and more about the specific commands and tools in the [CLI Reference](../../tools) chapter.

The Timeless Stack is not a build tool, and it's not just a container image builder;
Like other container systems, you can use `make`, `cake`, `rake`, `bake`,
or whatever's popular this month inside a Timeless Stack Formula;

### Some things the Timeless Stack is not

The Timeless Stack is not a build tool.  It does not replace `make`, `cake`,
`rake`, `bake`, or anything else.  The Timeless Stack is a framing for any (or all)
of these: by using `make` *inside* the Timeless Stack tools, you can version
and distribute `make` itself *and* the rest of the complete environment needed
for `make` to do what it needs to do.

The Timeless Stack is not a compiler.  It does not replace `gcc`, or `clang`,
or anything else.  The Timeless Stack is a framing for any of these: just like
with build tools, the purpose of the Timeless Stack is to lash together a
complete environment to make sure all of these tools can do their job.

The Timeless Stack is not (just) a container image builder (although it's
dang good at that).  Think of it more as a workspace manager:
It's important to have a clean workspace, fill it with good tools, and keep
the materials going both in and out of your workspace well-inventoried.
The Timeless Stack does all of this; and *unlike* other container systems,
with the Timeless Stack you can control the inputs separately,
update them separately, and choose to produce output results which
are smaller and more granular (and perhaps thus more composable and reusable?)
than the whole fileset you started with.

The Timeless Stack is not a distro.  (But [Radix](../what-is-radix) is!)
