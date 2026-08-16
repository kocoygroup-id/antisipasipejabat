#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PARENT=$(dirname "$ROOT")
SRC=$(basename "$ROOT")
VERSION=0.1.0.0
PACK=antisipasipejabat
HUMAN=AntisipasiPejabat-$VERSION

cd "$ROOT"
python3 tools/run_all_audits.py

cd "$PARENT"
tar -czf "$HUMAN.tar.z" --transform="s,^$SRC,$PACK," "$SRC"
cp "$HUMAN.tar.z" "$HUMAN.tar.Z"
tar -czf "$PACK-$VERSION.tgz" --transform="s,^$SRC,$PACK," "$SRC"
sha256sum "$HUMAN.tar.z" > "$HUMAN.tar.z.sha256"
sha256sum "$HUMAN.tar.Z" > "$HUMAN.tar.Z.sha256"
sha256sum "$PACK-$VERSION.tgz" > "$PACK-$VERSION.tgz.sha256"
echo "Created $HUMAN.tar.z, $HUMAN.tar.Z, and $PACK-$VERSION.tgz"
