+++
title = "Rio by Example"
weight = 30
+++

Rio by Example
==============

##### Getting a hash of an existing tarball sourced from HTTP

```bash
rio scan tar --source=http://gnu.ftp.org/whee.tgz
```

---

##### Getting a hash of a local directory

Suppose we have some files on our filesystem already.
For example:

```bash
mkdir foo
touch foo/bar
```

Now we want to use Rio to pack them:

```bash
rio pack tar ./foo
```

Example output:

```text
tar:26pqLaHWGFWi7WuBrreDtcs9ZR9dtmdQ3cCHySzb9Z6kBksDXg7u5tN6yvDUGyTHiN
```

This command only hashed the filesystem.  In order to save it,
we also need to tell rio a warehouse to put it in.
Let's use a content-addressable warehouse, on the local filesystem:

```bash
mkdir warehouse
rio pack tar --target=ca+file://./warehouse ./foo
```

The output is the same: the WareID.

We can inspect the tar file created with a regular `tar` command:

```bash
tar -tvf warehouse/26p/qLa/26pqLaHWGFWi7WuBrreDtcs9ZR9dtmdQ3cCHySzb9Z6kBksDXg7u5tN6yvDUGyTHiN
```

The output of this command may vary based on your system `tar` command, but
should roughly look like the following:

```text
drwxrwxr-x 1000/1000         0 2010-01-01 01:00 ./
-rw-r--r-- 1000/1000         0 2010-01-01 01:00 ./bar
```

Note that the ownership (uid, and gid) will always be 1000;
and similarly note the date is always fixed.
You can change these with the `--filter` flags, but the default is to normalize
these properties.
