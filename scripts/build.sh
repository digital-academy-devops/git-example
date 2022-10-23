#!/bin/bash
set -e

SCRIPT_DIR=$(readlink -f $(dirname $BASH_SOURCE))
ROOT_DIR=$(readlink -f "$SCRIPT_DIR/..")
BUILDDIR="$ROOT_DIR/build"

echo "Building yamlcv"
# importing $CV
source $SCRIPT_DIR/generate_cv.sh

echo "Building HTML from $CV"
yaml-cv yaml-cv $CV > $BUILDDIR/cv.html

echo "Building PDF from $CV"
yaml-cv yaml-cv $CV --pdf $BUILDDIR/cv.pdf

echo "Check files in $BUILDDIR"
