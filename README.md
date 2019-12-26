timeless docs website source
============================

This repo is the source for the repeatr.io website.

The site is built using `hugo` -- version 0.61-extended.
You'll also need to `git submodule update --init` to fetch
the themes into the right place.

(The dev tools flow is not currently well set up.  Sorry.)

Most documents might be browsable as their plain markdown,
but reading via github will probably encounter broken links;
there is not a 1:1 relationship between filenames that `hugo`
wants to see internally versus paths it publishes content as.

PRs, especially for small stuff and typos, extremely welcome.
More eyes on prose is always good.  :)

If you're considering large content changes, that's also welcome,
but please consider either opening an issue to discuss, or,
drafting via some collaborative editor (e.g. https://hackmd.io/ ?)
first -- github PRs can have a kind of inertia to them which is
problematic for good collaborative editing, and these alternatives
might make it easier to work together.
