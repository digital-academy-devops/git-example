#!/bin/bash
set -e

SCRIPT_DIR=$(readlink -f $(dirname $BASH_SOURCE))
ROOT_DIR=$(readlink -f "$SCRIPT_DIR/..")

SRCDIR="$ROOT_DIR/src"
BUILDDIR="$ROOT_DIR/build"

mkdir -p $BUILDDIR

SKILLS="$SRCDIR/skills.yaml"
YAMLCV="$SRCDIR/yamlcv.yaml"
export CV="$BUILDDIR/cv.yaml"

echo 'cleanup'
rm -vf $BUILDDIR/* 2>/dev/null
echo 'copy template'
cp -v $YAMLCV $CV

IFS=$'\n'
CATEGORIES=$(yq '.. comments="" | explode(.) | .categories[]' $SKILLS)

for CATEGORY in $CATEGORIES; do
   export CATEGORY
   export ITEMS=$(yq '.. comments="" | explode(.) | .skills[] | select(.category == env(CATEGORY)) | .name as $item ireduce ([]; . + $item) | join(",") ' $SKILLS | uniq)
   echo "updating '$CATEGORY' items in $CV"
   yq -i '.technical += {"category": env(CATEGORY), "items": env(ITEMS)}' $CV
done

echo "Successfully built $CV"
