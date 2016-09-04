#!/bin/sh -x

tmpdir=/tmp/scan.$$
name=`date +%F_%H_%M_%S`
dest=~cove/Dropbox/Scan
PATH=~cove/scanbd/tools:$PATH

echo "-------------- START SCAN --------------"
date
mkdir -p $tmpdir
scanadf --mode Color --source "ADF Duplex" --resolution 200 \
	--df-action Stop \
	-o $tmpdir/$name-pg%d.ppm

echo Done.
