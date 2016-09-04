#!/bin/sh -x

dest=~cove/Dropbox/Scan
PATH=~cove/scanbd/tools:$PATH

for each2 in /tmp/scan.*; do

	tmpdir=$each2
        name=`basename $each2 | sed -e 's/.ppm//g'`
	for each in $tmpdir/*.ppm; do
	    each=`basename $each .ppm`
            name=$each
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
done

echo Done.
