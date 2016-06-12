#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="merge-features"

mkdir -p "$DIR"
cd "$DIR"

MUTT_DIR="mutt-1.5.24"
BRANCH_LIST="bug-fixes cond-date fmemopen ifdef index-color initials limit-current-thread nested-if notmuch progress quasi-delete sidebar skip-quoted status-color tls-sni trash"

if [ ! -d "$MUTT_DIR" ]; then
	git clone -s "$SOURCE" -b "neomutt5" "$MUTT_DIR"

	pushd "$MUTT_DIR"
	for BRANCH in $BRANCH_LIST; do
		git branch "feature5/$BRANCH" "origin/feature5/$BRANCH"
	done
	popd
fi

MUTT_DIR="mutt-1.6.1"
BRANCH_LIST="bug-fixes compress cond-date fmemopen ifdef index-color initials keywords limit-current-thread nested-if nntp notmuch progress quasi-delete sidebar skip-quoted status-color tls-sni trash"

if [ ! -d "$MUTT_DIR" ]; then
	git clone -s "$SOURCE" -b "neomutt" "$MUTT_DIR"
	pushd "$MUTT_DIR"
	for BRANCH in $BRANCH_LIST; do
		git branch "feature/$BRANCH" "origin/feature/$BRANCH"
	done
	popd
fi

