#!/bin/sh -x

dest=~cove/Dropbox/Scan

success_sound=~cove/scanbd/sounds/Ping.aiff
fail_sound=~cove/scanbd/sounds/Basso.aiff
start_sound=~cove/scanbd/sounds/Tink.aiff
PATH=~cove/scanbd/tools:$PATH

for each2 in /tmp/scan.*; do

	tmpdir=$each2
        name=`basename $each2 | sed -e 's/.ppm//g'`
	for each in $tmpdir/*.ppm; do
	    each=`basename $each .ppm`
            name=$each
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
	 rm -rf $tmpdir
	fi
done

echo Done.
