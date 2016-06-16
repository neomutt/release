#!/bin/bash

DIR="../extract"

rm -fr "$DIR"
mkdir -p "$DIR"

git format-patch -o "$DIR/debian"  neomutt..debian
git format-patch -o "$DIR/copr"  neomutt..copr
git format-patch -o "$DIR/suse"    neomutt..suse
git format-patch -o "$DIR/fedora"  base..fedora
git format-patch -o "$DIR/freebsd" feature/sidebar..freebsd

git format-patch -o "$DIR/gentoo-pre" neomutt..gentoo-pre
git format-patch -o "$DIR/gentoo"     gentoo-pre..gentoo

git format-patch -o "$DIR/features-common" base..feature/sidebar
git format-patch -o "$DIR/features-extra" feature/sidebar..feature/notmuch
git format-patch -o "$DIR/bugs-neomutt" feature/notmuch..neomutt

