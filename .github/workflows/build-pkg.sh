#! /bin/sh

ZIPFILE=micronucleus-$(uname -m)-$(uname -s).zip
if [ -n "$ZIPLIB" ]; then cp "$ZIPLIB"; ZIPLIB=$(basename "$ZIPLIB"); fi
zip $ZIPFILE micronucleus${EXE_EXT} launcher${EXE_EXT} $ZIPLIB


