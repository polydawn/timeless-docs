+++
title = "Hello Repeatr"
weight = 35
+++

Hello Repeatr
=============

In this getting started doc, we'll show working examples
of using Repeatr to execute repeatable processes.

You should be able to copy the snippets in this file directly,
and they should work without modification.
You should be able to modify them afterwards to build in the
directions you wish to explore.


Computing with repeatr
----------------------

The first piece of the Timeless Stack we'll use is [Repeatr](/tools/repeatr).
Repeatr computes things -- and you guessed it, hopefully repeatedly.

Each time we ask Repeatr to do something, it will create a new, hermetically
isolated environment.  So, it will be our job to give Repeatr a list of all
the filesystems and we want so that isolated environment can be created.
We do this via a JSON document called a [Formula](/glossary#formula).

### "Hello, World" formula

```json
{
  "formula": {
    "inputs": {
      "/": "tar:6q7G4hWr283FpTa5Lf8heVqw9t97b5VoMU6AGszuBYAz9EzQdeHVFAou7c4W9vFcQ6"
    },
    "action": {
      "exec": ["/bin/echo", "hello world!"]
    }
  },
  "context": {
    "fetchUrls": {
      "/": [
        "ca+https://repeatr.s3.amazonaws.com/warehouse/"
      ]
    }
  }
}
```

This snippet is called formula (and some "context" configuration).
It lists the inputs we need -- these are specified using [WareID](/glossary#wareid)s --
and describes the action we want to run in the container.

Copy and paste formula and its context into a file called `example.formula`, and we can run it!

```bash
repeatr run example.formula
```

You should see a couple lines of logs scroll by, then the "hello" output, and finally, a JSON object.
The logs as repeatr sets up the environment are routed to stderr,
as is the "hello" print from the commands run in the container.
The json object comes out on stdout -- and is the only thing on stdout, so you can easily pipe this to other tools (e.g. [`jq`](https://stedolan.github.io/jq/)).

```text
log: lvl=info msg=read for ware "tar:6q7G4hW...vFcQ6" opened from warehouse "ca+https://repeatr.s3.amazonaws.com/warehouse/"
hello world!
{
  "guid": "by356nem-e0trxfw4-mt4xk1m9",
  "formulaID": "VvzXuRSogyW7JXvt49JWSfbJoAhpovCRPM69bd8xnDXyU8L5TMhrUmKGodWffysmK",
  "results": {},
  "exitCode": 0,
  // ...additional metadata elided...
}
```

This json object is called a [RunRecord](/glossary#runrecord).
You get one from every `repeatr run` invocation, and they describe
both the setup (the `formulaID` property is a hash describing the formula we just ran!  This will be very useful, later), and the results... this time, we have an empty `results` field, but we'll see that used in just a moment; also, you can see the command in the container exited successfully by the `"exitCode": 0` line.

This is a reliable, repeatable way to distribute software and run it regardless of host environment.
But it's actually pretty boring!  Let's *build something* with it, next.


### Producing outputs

This is a formula that produces outputs:

```json
{
  "formula": {
    "inputs": {
      "/": "tar:6q7G4hWr283FpTa5Lf8heVqw9t97b5VoMU6AGszuBYAz9EzQdeHVFAou7c4W9vFcQ6"
    },
    "action": {
      "exec": ["/bin/mkdir", "-p", "/task/out/beep"]
    },
    "outputs": {
      "/task/out": {"packtype": "tar"}
    }
  },
  "context": {
    "fetchUrls": {
      "/": [
        "ca+https://repeatr.s3.amazonaws.com/warehouse/"
      ],
    },
    "saveUrls": {
      "/task/out": "ca+file://./warehouse/"
    }
  }
}
```

As you can see, a formula with outputs isn't much more than what we've already seen:
you just name the filesystem path you want to save when the container exits, and Repeatr will make it happen.

As with the fetchURLs for inputs, we now have saveURLs for the output.
These are optional; you can list an output but no matching saveURL if you want to hash it, but discard the data.
But typically of course you do want to save the output, so you can either
pass it on to more formulas, or use `rio unpack` to extract it on your host.

Okay, let's `run`:

```
{
  "guid": "by37z50k-6kh08vp6-ofnhpc8c",
  "formulaID": "8jjTTBhvBixJZz2XcV6UjpmdnJSFz1QoR17E8UqcYNjM3gJc7nfRN5ithU6FGTLaTe",
  "results": {
    "/task/out": "tar:729LuUdChuu7traKQHNVAoWD9AjmrdCY4QUquhU6sPeRktVKrHo4k4cSaiQ523Nn4D"
  },
  "exitCode": 0,
  // ...additional metadata elided...
}
```

Now our RunRecord's `results` field has members!
There will be one entry for every entry you requested in the formula's `outputs` section.
Each value is a WareID -- the same format we use to identify formula `inputs`.

Congrats!  You just made your first reproducibly-build ware :D

But where did it go?

Here, our saveURL was `ca+file://./warehouse/`.  This URL indicates three things:

- `file://` indicates we'll use the local filesystem as the storage warehouse;
- the `ca+` prefix indicates we'll use it in [Content Addressable mode](./internals/content-addr-layout.md#tar)
- `./warehouse` is the local directory we'll store things at.

So, if you run `find ./warehouse` on your host, you should now see a file with a (quite long) path which is the hash you just saw in the runrecord.
That's your packed ware.
Since we're using the "tar" pack format in this example, you can actually extract it with any regular `tar` command -- but maybe hang on; we'll cover the `rio pack` and `rio unpack` commands in a sec, which are a bit smoother (and handle things consistently for other pack formats, as well).

Since the results are WareIDs, and inputs to formulas are WareIDs,
we don't have to stop here and unpack the results -- we can chain formulas together to build more complex software.
We'll demonstrate formula chaining right after the unpack commands.

### Other things to try

There are lots of different options you can configure in formulas,
such as setting environment variables, setting the user IDs to run as, and many other knobs to twiddle.
We'll skip over those in this quickstart.

One thing you may have wondered already is why the "context" is separate from the "formula".
You can answer that question by changing some of the "context" fields
-- say, adding or removing more URLs to the fetchUrls list --
and then calling `repeatr run` again.
Notice anything?
The `formulaID` doesn't change ;)


Next
----

In the next sections:

- we'll cover using `rio` to pack and unpack files -- which lets us import things into the Timeless Stack for processing, and export results again as plain files;
- we'll cover using `reach` to build larger computations with interdependencies -- which lets us handle large projects with the Timeless Stack tools!
