#!/bin/sh

export TMPDIR=/tmp
ocr=/opt/ABBYYOCR9/abbyyocr9

$ocr -id \
	--recognitionLanguage English \
	-if $1 \
	--outputFileFormat PDFA \
	--pdfaExportMode ImageOnText \
	-of $2

#	--pdfaMrcMRCEnabled \

