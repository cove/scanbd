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

for each in $tmpdir/*.ppm; do
    each=`basename $each .ppm`
    ppmtojpeg $tmpdir/$each.ppm > $tmpdir/$each.jpg
    trimmer -s all -f 20 $tmpdir/$each.jpg $tmpdir/u$each.jpg
done

convert $tmpdir/u*.jpg $tmpdir/$name.pdf
ocr $tmpdir/$name.pdf $tmpdir/o$name.pdf

cp $tmpdir/o$name.pdf $dest/$name.pdf
chown cove $dest/$name.pdf
pdfinfo $dest/$name.pdf
if [ $? -eq 0 ]; then
 rm -rf $tmpdir
fi

echo Done.
