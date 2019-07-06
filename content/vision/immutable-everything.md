+++
title = "Immutable Everything"
weight = 20
chapter = false
+++

Immutable Everything
====================


Why hashes?
-----------

> Or, "Why can't I just download "somefoo-vbar.baz.tar.gz"?"

Repeatr and the Timeless Stack uses hashes for [WareIDs](/glossary#wareid) for the same reason stores use SKUs and part numbers: consistency and reliability.

As an individual, you can go to a hardware store and ask for a 5mm screw.  But you haven't really picked yet by saying that: the store staff will show you to an entire rack of screws.

If you're the manager of a factory, you order your screws by their part number, because you don't want to re-order screws halfway through a project and end up with a subtly different threading, or screws that are too *long* in some other dimension, and so forth.
Similarly, as a hardware store manager, your organize your stocks and reorder supplies by their SKUs, because *consistency is important*.

Store bins may have labels of all sorts of descriptions in various precision to help you select which items you need, but the store itself is tracking inventory by SKUs, because a single, precise identifier is vastly simpler to work with.

Repeatr is the same: we use hashes to identify files and data because it's *simple* and it's *consistent* and it's *immune to silent changes* over time.
End-to-end use of hashes is part of what makes the Timeless Stack... *timeless*.
