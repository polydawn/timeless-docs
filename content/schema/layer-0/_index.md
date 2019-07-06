+++
title = "Layer 0 (Content)"
weight = 1
+++

Layer 0 Schema
==============

Layer 0 of the design is a simple spec for how to refer to snapshots of data.

(Refer to the [Design chapter](/design) if further contextualization is required.)

### Schema

The key concept at Layer 0 is the `WareID`.

```ipldsch
{{% readfile file="schema.ipldsch" %}}
```

The schema for Layer 0 is pretty simple and pretty terse: we just need to
declare that there exist some content identifiers; and we can handle them
as strings.  That's all we need.  (We'll build *interesting* stuff out of
this in Layer 1 -- all those definitions will build upon these.)
