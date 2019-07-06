+++
title = "Requirements"
weight = 20
+++

Requirements and Compatibility
==============================

The Timeless Stack components are designed to be as host-independent as possible.
However, the virtualization hits metal *somewhere*; there are *always* compatibility issues.
This page is for the common concerns.

tl;dr
-----

Run Linux and be prepared to deploy `sudo`.

(No, we're not happy about the `sudo`; but for the record, other container systems have the same limitations and tend to have hidden it from you by shipping setuid-root binaries.  We just don't hide it.)

Any linux should do.

---

Read on if you're interested in more details, and for semi-supported usage;
otherwise, you can skip the rest of this page.

---

Privileges
----------

Repeatr is built heavily upon linux containers.
As such, elevated privileges are required in order to launch them.

Effectively, it is the simplest to run Repeatr as root.

(Note that other popular container systems are the same.
Docker, for example, is noteworthy for trying to conceal this: however,
the docker daemon is setuid-root, and does indeed run with maximum privileges.)

### privileges in detail

- Operation: unpacking files:
	- Unpacking files to the host filesystem requires capabilies such as `cap_fowner`, `cap_fsetid`, `cap_setgid`, `cap_setuid`, etc.
- Operation: assembling filesystem:
	- Assembling filesystems for container launch requires mounting (both creating bind mounts and overlayfs mounts): creating mounts on linux automatically requires `cap_sysadmin`.  This is the primary reason running Repeatr requires escalated host privileges.
- Operation: launching containers:
	- Depends on the exact executor implementation, but typically, requires `cap_sysadmin` (container engines tend to require more mounting and other high-priv operations).
	- Some executors such as `--executor=chroot` only require `cap_chroot`.
	- Some executors such as `--executor=gvisor` require no special privileges at all (!)... but note the requirements for unpacking and assembling filesystems still apply.

Contributors interested in further reducing the privilege requirements are welcome, but be advised the mounting requirements are a fairly fundamental issue in Linux itself.
We can definitely make incremental improvements to our privilege requirements,
but very creative thinking will be required to address the trickier issues.


Host OS
-------

The Timeless Stack components are designed to be as host-independent as possible.
However, presently, best results are going to be via a Linux host.

### linux

Repeatr's default executors are based heavily upon linux containers.

Almost any reasonably modern linux kernel should work.

(The default executor is `runc` -- the same containment engine used by Docker.)

### macOS

MacOS is very nearly supported, via use of the `--executor=chroot` flag on Repeatr!

Mac isn't, however, *tested* at present, so be advised you're likely to run into snags.  Contributors and maintainers for Mac support welcome!

(If you're interested in contributing on Mac support: It's a relatively small burden!  Mainly, we just need someone to exercise and test things regularly to ensure there are no regressions.  So please jump in!)

### windows

Windows support is currently out of scope.

We're interested in making Windows support (both as a host for linux processes via some kind of emulation, and for native windows processes via HCS sandboxes)
a feature of Repeatr.  Contributors welcome; and we've reserved space in the APIs for these features; but be advised this is a sizable task.

### via VMs

Running the Timeless Stack inside a VM should work fine.

Support for having Repeatr transparently use VMs as an [executor](/design/executors) is desired;
contributions welcome.

### nested containers

Be advised that attempting to run Repeatr inside other container systems may be tricky.

Nested containers do not typically... work.
It may be possible to get the desired effects through flags such as `--executor=chroot`, but support for configuring this throughout higher-level tools is in the early stages.
Be advised you may need to hack some things together.

(Other systems such as "docker-in-docker" typically cheat: they're mounting a socket in the nested container that allows it to call out, and doing all actual privileged operations from the outside; this approach is hacky, does not have good security properties, and does not compose.)


Libraries
---------

There are no host library dependencies.

All components of the Timeless Stack are shipped as statically linked.
