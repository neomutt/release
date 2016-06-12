# List of Release Jobs

## Intro

List of credentials needed

## Synchronise

### Mutt Upstream -> Home -> GitHub

source: http://dev.mutt.org/hg/mutt/
mirror: https://bitbucket.org/mutt/mutt
update-from-hg.sh

Mutt branches
    default -> mutt/default (merge)
    default -> mutt/default-clean
    stable  -> mutt/stable

### Travis

Push to GitHub:
    mutt/default
    mutt/stable

check builds
    https://travis-ci.org/neomutt/neomutt/branches
    mutt/default
    mutt/stable

### Merge New Stable

If there's a new stable version of Mutt (1.6.n), then merge it into the
features:
    bug-fixes
    compress
    cond-date
    fmemopen
    ifdef
    index-color
    initials
    keywords
    limit-current-thread
    nested-if
    nntp
    notmuch
    progress
    quasi-delete
    sidebar
    skip-quoted
    status-color
    tls-sni
    trash

## Upstreams

Check for upstream changes and synchronise

### Sidebar

Cherry Pick: default -> sidebar

Are there any commits in mutt/default that need to be in feature/sidebar?
    Bug fixes
        sync bug fixes I've applied, but are different in mutt/default
    Style changes
        Anything to make the diffs smaller
    File renames
        e.g. doc files -> contrib

After sync, note hash of latest sync'd commit (both git and hg)

Last sync: 2016-06-11

### NNTP
    Vsevolod Volkov (vvv) <vvv@mutt.org.ua>
    http://mutt.org.ua/download/current/

    Last sync: 2016-06-11
    patch-1.6.0.vvv.nntp.gz

    Get latest release
    Apply it to 1.6.1
    Apply my changes
    Compare

    Send change upstream

### Keywords
    David Champion (dgc) <dgc@bikeshed.us>
    https://bitbucket.org/dgc/mutt-dgc
    last update: 2015-05-11

    Last sync: 2016-06-11

    Get latest release
    Apply it to 1.6.1
    Apply my changes
    Compare

    Send change upstream

### Notmuch
    Karel Zak
    https://github.com/karelzak/mutt-kz

    Bi-directional sync

Pull
    all notmuch changes
    all bug-fixes for minor features
    all bug-fixes for sidebar

Push

Bugs -- offer some important bug fixes
	01 feature/bug-fixes

Minor - push minor changes to mutt-kz
	02 feature/quasi-delete
	03 feature/progress
	04 feature/status-color
	05 feature/index-color
	06 feature/nested-if
	07 feature/cond-date
	08 feature/tls-sni

Major - push major changes to mutt-kz
	09 feature/sidebar
	10 feature/notmuch

Mutt - new stable release
    11 mutt/stable

Last sync: 2016-06-11

bug-fixes    333f8a6 separate key bindings for <return> and <enter>
cond-date    c1e9f15 doc: check for installed patches
index-color  94cf539 doc: check for installed patches
nested-if    ed20705 doc: check for installed patches
notmuch      d4885e2 use the new notmuch functions that return a status
progress     345e4e0 doc: check for installed patches
quasi-delete 22530e2 doc: check for installed patches
sidebar      a5a96fd Fix sidebar buffy stats updating on mailbox close.
status-color 6c65910 doc: check for installed patches
tls-sni      b065671 doc: check for installed patches
upstream     10ad31e use the new notmuch functions that return a status

### Gentoo

Gentoo has mutt/default's new windows
It might need some fixes from mutt/default

This needs to happen in the "Patch Sets" section

## Backport

Backport some features back to 1.5.24
Urgent bug-fixes, sidebar improvements

### Bugs
	01 feature/bug-fixes

### Minor
	02 feature/quasi-delete
	03 feature/progress
	04 feature/status-color
	05 feature/index-color
	06 feature/nested-if
	07 feature/cond-date
	08 feature/tls-sni

### Major
	09 feature/sidebar
	10 feature/notmuch

### Extra
	11 feature/ifdef
	12 feature/fmemopen
	13 feature/initials
	14 feature/trash
	15 feature/limit-current-thread
	16 feature/skip-quoted

## Local build

### Features (1.5.24)

Two test builds
    Nothing enabled
    Everything enabled

For each feature:
    cond-date
    fmemopen
    ifdef
    index-color
    initials
    limit-current-thread
    nested-if
    notmuch
    progress
    quasi-delete
    sidebar
    skip-quoted
    status-color
    tls-sni
    trash

Do a test build of each commit in:
    bug-fixes

### Features (1.6.1)

Two test builds
    Nothing enabled
    Everything enabled

For each feature:
    compress
    cond-date
    fmemopen
    ifdef
    index-color
    initials
    keywords
    limit-current-thread
    nested-if
    nntp
    notmuch
    progress
    quasi-delete
    sidebar
    skip-quoted
    status-color
    tls-sni
    trash

Do a test build of each commit in:
    bug-fixes

### Travis

Push to GitHub:
    feature/*
    feature5/*

check builds
    https://travis-ci.org/neomutt/neomutt/branches
    only enabled for features (1.6.1)

## Merging

Merge feature branches into NeoMutt

Needs:
    gitattributes
    gitconfig
    git hook prepare-commit-msg

### Export changes

Save all the new commits as git patches:
    Create neomutt repo
    map-features.sh
    get-new-patches.sh

### Features (1.5.24)

Bugs
    01 bug-fixes

Minor
    02 quasi-delete
    03 progress
    04 status-color
    05 index-color
    06 nested-if
    07 cond-date
    08 tls-sni

Major
    09 sidebar
    10 notmuch

Extra
    11 ifdef
    12 fmemopen
    13 initials
    14 trash
    15 limit-current-thread
    16 skip-quoted

Show which branches need merging:
    git branch --no-merged

List of commits that are unmerged:
    for i in $(git branch --no-merged | cut -b3-); do echo $i; git log --oneline neomutt5..$i | indent; done

Check that each merge builds cleanly
    git rebase -i -p --exec "git clean -xdfq && build" origin/neomutt5

### Features (1.6.1)

Merge features into neomutt in this order:

Mutt
    00 mutt/stable

Bugs
    01 bug-fixes

Minor
    02 quasi-delete
    03 progress
    04 status-color
    05 index-color
    06 nested-if
    07 cond-date
    08 tls-sni

Major
    09 sidebar
    10 notmuch

Extra
    11 ifdef
    12 fmemopen
    13 initials
    14 trash
    15 limit-current-thread
    16 skip-quoted

New
    17 compress
    18 keywords
    19 nntp

Show which branches need merging:
    git branch --no-merged

List of commits that are unmerged:
    for i in $(git branch --no-merged | cut -b3-); do echo $i; git log --oneline neomutt..$i | indent; done

Check that each merge builds cleanly
    git rebase -i -p --exec "git clean -xdfq && build" origin/neomutt

### NeoMutt

Do a comprehensive build on NeoMutt and NeoMutt5
    neomutt-test-configs.sh

NeoMutt, NeoMutt5:
    Generate and commit ChangeLog.neomutt
    Bump version
        what needs changing?

### Travis

Push to GitHub:
    neomutt
    neomutt5

check build

### Coverity

Push neomutt to coverity
Check there are no glaring errors
    https://scan.coverity.com/projects/neomutt-neomutt

### Update web docs

Everything looks good, update docs to match current version

## Patch Sets

### Patch list

Generate lots of patches:
    1.5.24 patches
    devel patches
    description ∀ features + metadata
    fedora COPR
    autogenerate READMEs
    historic patches

### Create Tag
    Create a dated, annotated, signed tag

    DATE="$(date +%F)"
    export GIT_AUTHOR_DATE="$DATE 09:00:00"
    export GIT_COMMITTER_DATE="$DATE 09:00:00"
    DATE="${DATE//-}"
    git tag --sign neomutt-$DATE -m "NeoMutt release $DATE"

### Build Patch Tree

    need script to build tree using "git am"
    generate tags for distros
    generate branches for updates

### Generate patch branches

    format-patch to generate patches for each feature since last release
    no, should apply cleanly
    merge --ff feature branch
    cherry-pick feature branch

    Changes from previous release
    git log neomutt-YYYYMMDD..HEAD --merges

### Resolve changes

    Manually resolve changes

### Generate Patch Sets

    need script to generate patch sets from tree
    commit patches
    test build for each distro
    push to github

### Distros

    notify distro maintainers
    start COPR build
    update homebrew formula

## Generate Announcements

Generate all the news items in all the formats we'll need.
Take info from ChangeLog.neomutt, issues, email
    GitHub release notes
    Web news

### News
    sidebar in mutt
    > 100 stars
    disabled $sidebar_refresh_time

### Known Issues

Notmuch invidual patch isn't up-to-date with Sidebar changes

### Bug Fixes

    list of closed issues

### Credits

    authors
    helpers
    testers

give credit where it's due -- hg author vs committer?
on release
	n commits by m users (p new users)
	list of new
	list of returnees

### Features
    feature/bug-fixes
    feature/compress
    feature/cond-date
    feature/fmemopen
    feature/ifdef
    feature/index-color
    feature/initials
    feature/keywords
    feature/limit-current-thread
    feature/nested-if
    feature/nntp
    feature/notmuch
    feature/progress
    feature/quasi-delete
    feature/sidebar
    feature/skip-quoted
    feature/status-color
    feature/tls-sni
    feature/trash

### Distros

List of supported distos
Mention level of support
Mention features included
Links to installation instructions

### Development
    devel/lmdb
    devel/new-mail
    devel/sensible-browser

    rename "integration" to "discussion"

    rename
        feature5/* -> v1.5.24/feature/*
        neomutt5   -> v1.5.24/neomutt

    start [unstable/*]

    plans for next release?

    file moves from docs -> contrib

    notmuch rebase
    general rebase on release of 1.6.2?

### Deprecations
    devel/kevin-sidebar
    devel/win-sidebar
    devel/win-sidebar2
    issue/11
    issue/12

    homebrew-neomutt
        issue?

    mutt-kz (transfer repo)
        issue/12
        issue/130
        issue/133
        issue/135
        issue/138
        issue/140
        issue/141

    1.5.24 will be deprecated after YYYY-MM-DD
    no further updates

## Release

### Release Tag
    git push --tags github
    get assets - as soon as the tag is pushed to github, the assets can be downloaded

### GitHub Release
    list        https://github.com/neomutt/neomutt/releases
    latest      https://github.com/neomutt/neomutt/releases/latest
    specific    https://github.com/neomutt/neomutt/releases/tag/neomutt-YYYYMMDD
    assets
        https://github.com/neomutt/neomutt/archive/neomutt-YYYYMMDD.zip
        https://github.com/neomutt/neomutt/archive/neomutt-YYYYMMDD.tar.gz

    create archives
    push to github
    create release
    checksum and sign archives

### Publish News

    Push web page
    update title of issue (remove 'Future')
    close previous release issue

