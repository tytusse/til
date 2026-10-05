#!/usr/bin/env bash

set -x
set -eou pipefail

SCRIPT_DIR=$(realpath $(dirname $0))
cd "$SCRIPT_DIR"

if [[ -f foo.txt ]]; then
    rm -f foo.txt
fi

echo "42" > foo.txt
stat foo.txt > stat1.txt
podman build . -t=test-cache-of-add
echo "43" > foo.txt
stat foo.txt > stat2.txt

podman build . -t=test-cache-of-add

# diff will return non-zero if diff is found
# we dont want script to crash because of that
git diff --no-index stat1.txt stat2.txt || true
FOO_CONTENT=$(podman run --rm test-cache-of-add cat foo.txt)
if [[ "$FOO_CONTENT" == "42" ]]; then
    : expected 43; 42 means file was not cached
    exit 1
else
    : foo.txt in container is $FOO_CONTENT, meaning cache was invalidated properly
fi