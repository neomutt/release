#!/bin/bash

function lookup_commit()
{
	case "$1" in
		"feature: bug-fixes"*)            echo "bug-fixes"            ;;
		"feature: compress"*)             echo "compress"             ;;
		"feature: conditional dates"*)    echo "cond-date"            ;;
		"feature: fmemopen"*)             echo "fmemopen"             ;;
		"feature: ifdef"*)                echo "ifdef"                ;;
		"feature: index-color"*)          echo "index-color"          ;;
		"feature: initials"*)             echo "initials"             ;;
		"feature: keywords"*)             echo "keywords"             ;;
		"feature: limit-current-thread"*) echo "limit-current-thread" ;;
		"feature: nested-if"*)            echo "nested-if"            ;;
		"feature: nntp"*)                 echo "nntp"                 ;;
		"feature: notmuch")               echo "notmuch"              ;;
		"feature: progress bar"*)         echo "progress"             ;;
		"feature: quasi-delete"*)         echo "quasi-delete"         ;;
		"feature: sidebar"*)              echo "sidebar"              ;;
		"feature: skip-quoted"*)          echo "skip-quoted"          ;;
		"feature: status-color"*)         echo "status-color"         ;;
		"feature: tls sni"*)              echo "tls-sni"              ;;
		"feature: trash folder"*)         echo "trash"                ;;
		*) ;;
	esac
}


eval SOURCE="~mutt/neomutt.git"
DIR="int-tree"
PATCH_SETS="https://github.com/neomutt/integration"

mkdir -p "$DIR"
cd "$DIR"

BRANCH="patch-sets"
if [ ! -d "$BRANCH" ]; then
	git clone --ref "$SOURCE" "$PATCH_SETS" "$BRANCH"
fi

BRANCH="tree"
if [ ! -d "$BRANCH" ]; then
	git clone -s "$SOURCE" "$BRANCH"
	pushd "$BRANCH"
	git checkout -b base mutt-1.6.1
	git branch -D neomutt
	popd
fi

pushd "$BRANCH"

git checkout -b fedora mutt-1.6.1
git am ../patch-sets/fedora/*

git checkout -b freebsd mutt-1.6.1
git am ../patch-sets/features-common/*
git tag features-common
git am ../patch-sets/freebsd/*

git checkout -b neomutt features-common
git am ../patch-sets/features-extra/*
git tag features-extra
git am ../patch-sets/bugs-neomutt/*
git tag bugs-neomutt
git branch feature/bug-fixes

git checkout -b arch bugs-neomutt

git checkout -b homebrew bugs-neomutt

git checkout -b debian bugs-neomutt
git am ../patch-sets/debian/*

git checkout -b suse bugs-neomutt
git am ../patch-sets/suse/*

git checkout -b copr bugs-neomutt
git am ../patch-sets/copr/*

git checkout -b gentoo bugs-neomutt
git am ../patch-sets/gentoo-pre/*
git tag gentoo-pre
git am ../patch-sets/gentoo/*

git checkout neomutt

git log --oneline base..HEAD | while read HASH MSG; do
	BRANCH=$(lookup_commit "$MSG")
	[ -z "$BRANCH" ] && continue
	git branch feature/$BRANCH $HASH
	echo feature/$BRANCH
done

popd

# BRANCH="neomutt"
# if [ ! -d "$BRANCH" ]; then
# 	git clone -s "$SOURCE" "$BRANCH"
# fi

