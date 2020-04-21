#!/bin/sh

set -eux

NAME="$1"
DEPL="$2"

ARCHIVE=`grep "toktok/$DEPL" MANIFEST | sed -e "s|^toktok/$DEPL ||"`
mkdir -p "$$"
tar zxf "$ARCHIVE" -C "$$"
if [ "$2" == "--debug" ]; then
  devenv -debugexe "$$/$NAME/$NAME.exe"
else
  "$$/$NAME/$NAME"
fi
rm -r $$
