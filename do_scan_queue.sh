#!/bin/sh -x

tmpdir=/tmp/scan.$$
name=`date +%F_%H_%M_%S`
dest=~cove/Dropbox/Scan

success_sound=~cove/scanbd/sounds/Ping.aiff
fail_sound=~cove/scanbd/sounds/Basso.aiff
start_sound=~cove/scanbd/sounds/Tink.aiff
PATH=~cove/scanbd/tools:$PATH

echo "-------------- START SCAN --------------"
date
play -q $start_sound 
play -q $start_sound 
mkdir -p $tmpdir
scanadf --mode Color --source "ADF Duplex" --resolution 200 \
	--df-action Stop \
	-o $tmpdir/$name-pg%d.ppm

echo Done.
