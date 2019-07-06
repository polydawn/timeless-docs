+++
title = "Executors"
weight = 100
chapter = false
+++

Executors
=========

Within [Repeatr](/tools/repeatr) (the [Layer 1](../layers/#layer-1) execution tool), we have a set of plugins known as the "executor" plugins.

Executors have two basic responsibilities:

1. Execute a process
2. in a hermetic environment.

That's it.

Typically, we use an executor which uses "linux containers".
However, for the most part, we try to consider that an implementation detail.
Executors might also be simple chroots; or virtual machines; or other
interesting kinds of sandboxing.
Nor are executors strictly limited to the Linux operating system;
it's simply the most common place to work.

Different executors can be selected using the `--executor` flag when running `repeatr`.

---

{{% notice info %}}
The following sections are implementation details.
You can skip the rest of this page and still use the Timeless Stack.
<br><br>
This page may be interesting if you want to know more about how Repeatr isolates computation,
or if you're interested in implementing more executors.
{{% /notice %}}

### hacking: executors

All of the executor implementations are each in a package within the
https://github.com/polydawn/repeatr/tree/master/executor/impl directory.

The following executors are currently supported:

- [runc](https://runc.io) (the default)
- [gvisor](https://github.com/google/gvisor) (some setup required)
- [chroot](https://linux.die.net/man/2/chroot)

Each of these implementations is tested against a shared set of
behavioral specifications: https://github.com/polydawn/repeatr/tree/master/executor/tests
