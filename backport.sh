#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="backport"
BRANCH_LIST="bug-fixes quasi-delete progress status-color index-color nested-if cond-date tls-sni sidebar notmuch ifdef fmemopen initials trash limit-current-thread skip-quoted"

mkdir -p "$DIR"
cd "$DIR"

for BRANCH in $BRANCH_LIST; do
    if [ ! -d "${BRANCH}5" ]; then
        git clone -s "$SOURCE" -b "feature5/$BRANCH" "${BRANCH}5"
    fi
    if [ ! -d "${BRANCH}6" ]; then
        git clone -s "$SOURCE" -b "feature/$BRANCH" "${BRANCH}6"
    fi
done

for BRANCH in $BRANCH_LIST; do
    pushd "${BRANCH}5"
    git log --oneline --no-merges > ../"${BRANCH}5.txt"
    popd
    pushd "${BRANCH}6"
    git log --oneline --no-merges > ../"${BRANCH}6.txt"
    popd
done


