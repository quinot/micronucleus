#! /bin/sh

ZIPFILE=micronucleus-$(uname -m)-$(uname -s).zip
if [ -n "$ZIPLIB" ]; then eval "cp $ZIPLIB ."; ZIPLIB=$(basename "$ZIPLIB"); fi
eval zip $ZIPFILE micronucleus${EXE_EXT} launcher${EXE_EXT} $ZIPLIB


