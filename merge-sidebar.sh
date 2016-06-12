#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="merge-sidebar"

mkdir -p "$DIR"
cd "$DIR"

BRANCH="stable"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" -b "mutt/$BRANCH" "$BRANCH"
fi
pushd "$BRANCH"
git log --oneline --no-merges > ../"$BRANCH.txt"
popd

BRANCH="default"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" -b "mutt/$BRANCH" "$BRANCH"
fi
pushd "$BRANCH"
git log --oneline --no-merges > ../"$BRANCH.txt"
popd

BRANCH="sidebar"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" -b "feature/$BRANCH" "$BRANCH"
fi
pushd "$BRANCH"
git log --oneline --no-merges > ../"$BRANCH.txt"
popd

