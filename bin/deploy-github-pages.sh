#! /usr/bin/env bash
set -e

WORKDIR=${WORKDIR:-deployed}
BRANCH=${BRANCH:-gh-pages}

if ! git clone --single-branch -b $BRANCH $REPOSITORY_URL $WORKDIR; then
    mkdir -p $WORKDIR
fi

yarn run generate

cp -Rf dist/* $WORKDIR/
echo $CNAME > $WORKDIR/CNAME

cd $WORKDIR
git init
git add .

if git commit -m "Deploy $CIRCLE_SHA1";
  then
    git push $REPOSITORY_URL HEAD:$BRANCH
fi
