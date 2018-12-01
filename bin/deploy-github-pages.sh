#! /usr/bin/env bash
set -e

WORKDIR=deployed

git clone --single-branch -b $BRANCH $CIRCLE_REPOSITORY_URL $WORKDIR

yarn run generate

cp -Rf dist/* $WORKDIR/

echo $CNAME > $WORKDIR/CNAME

cd $WORKDIR

git add .
git commit -m "Deploy $CIRCLE_SHA1"
git push $CIRCLE_REPOSITORY_URL HEAD:$BRANCH
