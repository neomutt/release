#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="test-build"

mkdir -p "$DIR"
cd "$DIR"

BRANCH_LIST="bug-fixes cond-date fmemopen ifdef index-color initials limit-current-thread nested-if notmuch progress quasi-delete sidebar skip-quoted status-color tls-sni trash"

for BRANCH in $BRANCH_LIST; do
    if [ ! -d "${BRANCH}5" ]; then
        git clone -s "$SOURCE" -b "feature5/$BRANCH" "${BRANCH}5"
    fi
done

BRANCH_LIST="bug-fixes compress cond-date fmemopen ifdef index-color initials keywords limit-current-thread nested-if nntp notmuch progress quasi-delete sidebar skip-quoted status-color tls-sni trash"

for BRANCH in $BRANCH_LIST; do
    if [ ! -d "${BRANCH}6" ]; then
        git clone -s "$SOURCE" -b "feature/$BRANCH" "${BRANCH}6"
    fi
done

