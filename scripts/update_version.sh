#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Error: Please provide the version."
    exit 1
fi

mvn versions:set -DnewVersion="$1"

mvn exec:java -Dexec.mainClass="ChangeLogUpdater" -Dexec.args="$1"

sed -i.bck "s|version=\"[0-9]*\.[0-9]*\.[0-9]*.*\"|version=\"$1\"|" Dockerfile && rm -fr Dockerfile.bck

mvn clean install

git add .
git commit -m "$1"
git tag "$1"