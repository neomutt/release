#!/bin/bash

# first, run map-features.sh to create feature branches

for i in $(git branch --no-merged | cut -b3-); do
	BRANCH="$i"
	FIRST_COMMIT="$(git log --reverse --oneline neomutt..$i | sed 's/ .*//;q')"
	git format-patch -o "$BRANCH" "$FIRST_COMMIT^..$BRANCH"
done

