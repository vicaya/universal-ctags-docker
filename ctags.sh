#!/bin/sh
exec docker run --rm -v="$PWD:/workspace" vicaya/universal-ctags "$@"
