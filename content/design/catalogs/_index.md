+++
title = "Catalogs & Releasing"
weight = 60
chapter = false
+++

Catalogs & Releasing
====================

The Timeless Stack is primarily designed around hashes for their certainty.
How, then, does this jive with some of the most fundamental needs of software design:
to update things you depend on when improved or fixed versions are available,
and how to publish information about your own products for others who want to update?

The Timeless Stack answer to that is called Catalogs.

### What does a Catalog do?

A Catalog is a mapping of human-readable and names to hashes.
It does this in a well-standardized way that's based on merkle trees, so
it's easy to track changes and easy to share in a decentralized way.

### Where do Catalogs plug in?

[Module Imports](/glossary#module-import) refer to Catalog names, which
lets Modules get content by name instead of hash.

When building things and wanting to share them, the keys in a
[Module Exports](/glossary#module-export) map will become Catalog Item Labels
(which we'll explain in the next section).

Catalogs themselves are just a bunch of files.  They can be transported in
a git repo (often practical!) or any other kind of [Ware](/glossary#ware).

### What kind of naming is used?

Catalogs naming is a three-tuple, with each parameter identifying a data structure,
and each additional parameter getting more zoomed into that structure:

- **Lineage label** -- a lineage represents a project (whatever that means to you),
  and a single authoring party.
- **Release label** -- a lineage contains a series of releases,
  and each release may contain several items.
  A release is appended to a lineage as one atomic object!
  Releases can be tagged with all sorts of metadata.
- **Item label** -- releases often contain several "items" -- a typical example
  is a "docs" item, a "linux-amd64" item, a "darwin-amd64" item, etc.
  The Item Label maps directly onto a [WareID](/glossary#wareid)

Collectively, a set of lineages are called a Catalog.

You can see a concrete example (in JSON format) of what this looks like in the
next section on [example data](#example-data).

These divisions are based on how frequently and how atomically the content is updated:

- A Lineage is something created fairly rarely -- at the same rate as christening
  projects (again, whatever that means to you -- we're providing tools here, not policy).
  It's a structure you append when making releases.
- Many Releases will be created and appended toa Lineage over time.
  Each Release is something that is created atomically: the idea is that for example
  when producing a bunch of software that has platform-specific releases,
  one would build all of those at once, and make a single release containing
  each of them as a labeled item.

### Example data

Here is an example of a single lineage, containing three releases,
each of which has three or four WareIDs itemized in the release:

```
{
  "name": "domain.org/team/project",
  "releases": [
    {
      "name": "v2.0rc1",
      "items": {
        "docs":         "tar:SiUoVi9KiSJoQ0vE29VJDWiEjFlK9s",
        "linux-amd64":  "tar:Ee0usTSDBLZjgjZ8NkMmCPTHtjUb5r",
        "darwin-amd64": "tar:G9ei3jf9weiq00ijvlekK9deJjFjwi",
        "src":          "tar:KE29VJDJKWlSiUoV9siEjF0vi9iSoQ"
      },
      "metadata": {
        "anything": "goes here -- it's a map[string]string",
        "semver":   "2.0rc1",
        "tracks":   "nightly,beta,2.x"
      },
      "hazards": null,
    },{
      "name": "v1.1",
      "items": {
        "docs":         "tar:iSJSiUoVi9KoQ0vE29VJDWlK9siEjF",
        "linux-amd64":  "tar:BLZEe0usTSDjgjZ8NkMmCPUb5rTHtj",
        "darwin-amd64": "tar:weiG9ei3jf9q00ijvlekK9FjwideJj",
        "src":          "tar:KWlKE29VJDJSiUoV9siEjFiSoQ0vi9"
      },
      "metadata": {
        "anything": "goes here -- it's a map[string]string",
        "semver":   "1.1",
        "tracks":   "nightly,beta,stable,1.x"
      },
      "hazards": null,
    },{
      "name": "v1.0",
      "items": {
        "docs":         "tar:iUiSi0vE29VQJSoVK9sjFJDWiEl9Ko",
        "linux-amd64":  "tar:e0BLTjZ8NkMgZEusb5rtjmCPTHUSDj",
        "src":          "tar:E2KWJUoV9siilK9VSoQi9EjF0viDJS"
      },
      "metadata": {
        "anything": "goes here -- it's a map[string]string",
        "semver":   "1.0",
        "tracks":   "nightly,beta,stable,1.x"
      },
      "hazards": {
        "something critical": "CVE-asdf-1234"
      }
    }
  ]
}
```

This format is meant to be reasonable extensible: metadata of any kind can
be stored in the metadata maps.

The "hazard" map is a feature particularly interesting to the security-conscious:
while we want to support any kind of user-generated metadata without being
overly prescriptive, we also want certain kinds of information to come through
loud and clear even in a diverse community of users... like, for example,
critical security warnings!  The "hazard" map is meant to address this:
any time it's not null, the release can be red-flagged by any tooling.

Notice that each Release Label is unique, but also that releases are stored in
an ordered array rather than an unordered map.  This is to remove any potential
ambiguity or complex decision-making about the sorting when a user-facing tool
must decide in what order to present choices.
(Automation should refrain from assuming that the top of the list is "latest",
however -- remember, this is the *Timeless* Stack; "latest" is not a concept
we want to give much credence to at any point in time!)

### Labeling conventions

Release labels are free-text.  Typically, we recommend they start with a "v"
out of convention.  It is also typical to follow something roughly resembling
SemVer (though there are many, many variations on this, and the Timeless Stack
does not explicitly recommend nor require adherence to any particular variations
of SemVer rules).

Item labels are also free-text.  By convention, the most likely names you'll see
are similar to the ones in this example: "docs" and "src" are extremely common;
tuples representing architecture and host OS like "linux-amd64" are also common.
Usually, the same item names should occur in subsequent releases as in earlier
ones -- tooling that generates formulas using WareIDs from release catalogs
expects the *release* name to change for each new version, but the item names
to remain essentially constant.


Catalog Versioning
------------------

Recall that a Catalog is a collection of Lineage files.

A Catalog is something that can be versioned atomically as one snapshot!

This gives us support for [Reproducible Resolve](/vision/strategy/reproducible-resolve)!

Catalogs being a merkle-tree format also means they're easy to decentralize.
A subset of lineages in a Catalog that your project is interested in can be
extracted and vendored (copied) into your project's git tree: this produces
a decentralized, reliable system rich in metadata that works for you even
when offline.

// TODO expand this section

### Pollinating Catalogs

// TODO expand this section -- talk about decentralized push/pull


Replays
-------

Catalogs have one more killer feature: Replays.

So far, we've described the Lineage files, and the way they contain
a set of labeled [WareIDs](/glossary#wareid).  However, there's more!

Catalogs can also contain "replay" files.  One of these is associated with
each release entry.  And the look basically like... well, [Modules](/glossary#module).

Because they are.

Wouldn't it be nice if we could share all our build instructions
along with a release?

We can, and that's what Replays are.  Whenever building packages with a Module,
during release, we can simply *keep a copy* of that Module and embed it in
the release.  As long as that module only has imports of other catalog references
(i.e. [candidate](/tools/reach/workspace-layout#candidate-releases-recursing-across-modules)
references and ingests must be normalized to catalog imports for this to work;
see the [Modules-vs-Replayable-Modules](/schema/layer-2/#modules-vs-replayable-modules)
doc for details),
by versioning the Replay together with the Catalog itself, the entire thing can
be easily re-resolved into Formulas and executed again -- at any later date,
by anyone, with no prep work or manual setup necessary!

Since the keys in the [Module Exports](/glossary#module-export) map line up
1:1 with [Catalog Item Labels](/glossary#catalog-item-label), not only can we
easily re-execute the steps in a Replay, we can even check that it reproduces
the same artifacts as identified in the release!  (And it goes without saying
that this is how release tooling will name things in the first place, saving
you from having to repeat any of this information in command line flags during
release processes.)

Replays blend the line between "source-based" and "binary-based" software distribution.
(Not much more to say about that other than :tada:!)

### Recursive Explain

Catalogs and Replays, taken together, offer one of the most provocative features
of the Timeless Stack: "Recursive Explain".

Given some piece of data or some compiled program... where did it come from?
How was it made?  These are questions we can answer in the Timeless Stack:
and not just with documentation, or metadata making claims: with actual
executable proof.

Starting with a [WareID](/glossary#wareid) and a catalog reference --
the `lineageLabel:releaseLabel:itemLabel` tuple -- that resolves to that WareID,
we can:

1. check that the catalog reference resolves to that WareID;
2. now, look up the associated Replay in the Catalog.
3. look up all of the Replay's [Imports](/glossary#module-import) (they're all in the Catalog).
4. if unwilling to trust the Replay, optionally, run it again -- and check the results match the WareID.
5. for each [Import](/glossary#module-import) in the Replay... recurse!

Following this simple process, we can see not just the build process for
this particular WareID... but the build process for each thing used in building it.  Recursively!

For example, if we had a Lineage of "bash", we could follow its imports up to
see the build of the "libreadline" library it uses... and also, the build of
the "gcc" used to compile it.  And further: the build of "gcc" used to build
that "gcc"!

Recursive Explain can be used to audit software supply chain integrity,
gather debugging information,
understand process,
or feed information to other processes -- for example,
"gather all my transitive dependencies (and their build tool) and ensure their Wares are cached".

> // TODO may need explanation of "ouroboros mesh" here, and capability of
> // replays to refer to other releaseLabel of the its own lineage, and
> // a general explanation of how this relates to bootstrapping and DDC.
> // or, we need another page or seven for that, and to link it here.
