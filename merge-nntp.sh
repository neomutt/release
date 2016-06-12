#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="merge-nntp"
NNTP="http://mutt.org.ua/download/current/patch-1.6.0.vvv.nntp.gz"

mkdir -p "$DIR"
cd "$DIR"

FILE="${NNTP##*/}"
FILE="${FILE%.gz}"

if [ ! -f "$FILE" ]; then
	wget "$NNTP"
fi

gzip -d "$FILE.gz"

BRANCH="mutt"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" "$BRANCH"
	pushd "$BRANCH"
	git co -b nntp mutt-1.6.1
	patch -p1 < ../"$FILE"
	popd
fi

BRANCH="neo"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" -b "feature/nntp" "$BRANCH"
fi

