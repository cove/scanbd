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

for each in $tmpdir/*.ppm; do
    each=`basename $each .ppm`
    ppmtojpeg $tmpdir/$each.ppm > $tmpdir/$each.jpg
    #convert -set option:deskew:auto-crop 100 -deskew 40 \
    #	$tmpdir/$each.jpg $tmpdir/u$each.jpg
    trimmer -s all -f 20 $tmpdir/$each.jpg $tmpdir/u$each.jpg
    #unrotate -f 10 $tmpdir/$each.jpg $tmpdir/u$each.jpg
done

convert $tmpdir/u*.jpg $tmpdir/$name.pdf
ocr.sh $tmpdir/$name.pdf $tmpdir/o$name.pdf

cp $tmpdir/o$name.pdf $dest/$name.pdf
chown cove $dest/$name.pdf
pdfinfo $dest/$name.pdf
if [ $? -eq 0 ]; then
 amixer --quiet set Master 100 
 play -q $success_sound 
 play -q $success_sound 
 rm -rf $tmpdir
else
 amixer --quiet set Master 100 
 play -q $fail_sound
 play -q $fail_sound
fi

echo Done.
