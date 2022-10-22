#!/bin/bash
#set -x

SRC="src"
BUILD="build"

mkdir -p $BUILD

SKILLS="$SRC/skills.yaml"
YAMLCV="$SRC/yamlcv.yaml"
CV="$BUILD/cv.yaml"

echo 'cleanup'
rm -vf $BUILD/* 2>/dev/null
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
