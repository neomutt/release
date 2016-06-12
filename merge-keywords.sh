#!/bin/bash

eval SOURCE="~mutt/neomutt.git"
DIR="merge-keywords"

mkdir -p "$DIR"
cd "$DIR"

BRANCH="neo"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" -b "feature/keywords" "$BRANCH"
fi

