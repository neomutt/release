#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="merge-notmuch"
NOTMUCH="https://github.com/karelzak/mutt-kz"
TRANSFER="https://github.com/neomutt/mutt-kz"
BRANCH_LIST="bug-fixes quasi-delete progress status-color index-color nested-if cond-date tls-sni sidebar notmuch"

mkdir -p "$DIR"
cd "$DIR"

BRANCH="upstream"
if [ ! -d "$BRANCH" ]; then
	git clone --ref "$SOURCE" "$NOTMUCH" "$BRANCH"
fi
pushd "$BRANCH"
git log --oneline --no-merges > ../"$BRANCH.txt"
popd

BRANCH="transfer"
if [ ! -d "$BRANCH" ]; then
	git clone --ref "$SOURCE" "$TRANSFER" "$BRANCH"
fi
pushd "$BRANCH"
git log --oneline --no-merges > ../"$BRANCH.txt"
popd

for BRANCH in $BRANCH_LIST; do
    if [ ! -d "$BRANCH" ]; then
        git clone -s "$SOURCE" -b "feature/$BRANCH" "$BRANCH"
    fi
done

for BRANCH in $BRANCH_LIST; do
    pushd "$BRANCH"
    git log --oneline --no-merges > ../"$BRANCH.txt"
    popd
done


