#!/bin/sh
IMG=vicaya/universal-ctags

docker images --format '{{.CreatedSince}}' "$IMG" | head -1 | \
  grep hour > /dev/null || docker pull "$IMG"

exec docker run --rm -v="$PWD:/workspace" vicaya/universal-ctags "$@"
