+++
title = "Layer 1 (Execute)"
weight = 10
+++

Layer 1 Schema
==============

Layer 1 of the design is regarding the description of a single atom of computation.

(Refer to the [Design chapter](/design) if further contextualization is required.)

### Schema

The key concepts at Layer 1 are the `Formula` and the `RunRecord`.

```ipldsch
{{% readfile file="schema.ipldsch" %}}
```

### example formula

This is a concrete example of a formula, in JSON format:

```formula
{{% readfile file="example1.formula" %}}
```

As you can see, this Formula has only a single input, and lists a single output.
The output will be packed into a tar format, and when we evaluate the formula,
we'll expect the resultant RunRecord to contain one value in the results map
corresponding to this output we requests.

This is the RunRecord that should be produced:


```runrecord
{{% readfile file="example1.runrecord" %}}
```

Note that since there are no `"saveUrls"` specified in the context,
no tar file was actually emitted; the data was only hashed (and then effectively
routed to `/dev/null`).  You can add a `context.saveUrls` map to change this.
