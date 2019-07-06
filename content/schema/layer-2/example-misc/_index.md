+++
title = "Misc examples"
weight = 900
+++

Misc snippets & Examples
------------------------

To ingest a local git repo, use this ImportRef:

```text
"ingest:git:.:HEAD"
```

---

To ingest a local filesystem (using `tar` as the pack format), use this ImportRef:

```text
"ingest:pack:tar:./"
```

---

To wiggle a host mount into a container through module imports, use this ImportRef:

```text
ingest:literal:mount:ro:/etc/host/mount/path
```

(This might be useful for making secrets available to a container in a build
pipeline, for example.  But be careful with this feature!  It (obviously) makes
your system unreproducible on other machines without the same host state!)

Note: in order to do this in a Repeatr Formula inputs (as contrasted to Module imports), use this shorter string:

```text
mount:ro:/etc/host/mount/path
```
