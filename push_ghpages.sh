#!/bin/bash
set -euo pipefail
set -x

hugo

rm -rf ghpublish || true
cp -r hugo/_publish ghpublish
git init ghpublish
(cd ghpublish
	git remote add github git@github.com:polydawn/polydawn.github.io.git
	echo -n "repeatr.io" > CNAME # github pages config
	git add .
	git commit -m 'site'
	git push -f github
)