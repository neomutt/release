#!/bin/bash

# set -o errexit	# set -e
# set -o nounset	# set -u

function log_error()
{
	echo -e "\e[1;31m$@\e[m"
}

function log_success()
{
	echo -e "\e[1;32m$@\e[m"
}

function die()
{
	if [ $? = 1 ]; then
		log_error "Build failed"
	fi
}


trap die EXIT

DIR="neo"

COMPILERS=(
	gcc
	# clang
)

OPTIONS=(
	# Default config
	""
	# Disable components that default to 'on'
	"--disable-fcntl"
	"--disable-iconv"
	"--disable-nls"
	"--with-included-gettext"
	"--without-idn"
	"--without-wc-funcs"
	"--disable-pgp"
	"--disable-smime"
	# Disable ALL optional components
	"--disable-fcntl --disable-iconv --disable-nls --with-included-gettext --without-idn --without-wc-funcs --disable-pgp --disable-smime"
	# Enable components that default to 'off'
	"--enable-pop"
	"--enable-imap"
	"--enable-smtp"
	"--enable-debug"
	"--enable-flock"
	"--enable-nfs-fix"
	"--enable-mailtool"
	"--enable-locales-fix"
	"--enable-exact-address"
	"--with-homespool"
	"--with-domain"
	"--with-regex"
	"--enable-sidebar"
	"--enable-notmuch"
	"--enable-gpgme"
	"--with-mixmaster"
	# Enable ALL optional components
	"--enable-pop --enable-imap --enable-smtp --enable-debug --enable-flock --enable-nfs-fix --enable-mailtool --enable-locales-fix --enable-exact-address --with-homespool --with-domain --with-regex --enable-sidebar --enable-notmuch --enable-gpgme --with-mixmaster"
	# Test all the backend caching options
	"--enable-hcache                        --without-qdbm --without-gdbm --without-bdb"
	"--enable-hcache --without-tokyocabinet                --without-gdbm --without-bdb"
	"--enable-hcache --without-tokyocabinet --without-qdbm                --without-bdb"
	"--enable-hcache --without-tokyocabinet --without-qdbm --without-gdbm"
	# Test the components that have dependencies on others
	"--with-gss --enable-imap"
	"--with-ssl --enable-pop"
	"--with-ssl --enable-imap"
	"--with-ssl --enable-smtp"
	"--with-gnutls --enable-pop"
	"--with-gnutls --enable-imap"
	"--with-gnutls --enable-smtp"
	"--with-sasl --enable-pop"
	"--with-sasl --enable-imap"
	# Test SLANG (not default Curses)
	"--with-slang"
	# Miscellaneous options
	"--with-mailpath=/home/mutt/mail"
	"--with-exec-shell=/bin/bash"
	"--enable-sidebar --enable-notmuch"
)


TOTAL=$((${#COMPILERS[@]} * ${#OPTIONS[@]})) 
echo "Testing $TOTAL configurations"

pushd "$DIR" >& /dev/null

COUNT=1
SUCCESS=0
for c in "${COMPILERS[@]}"; do
	for o in "${OPTIONS[@]}"; do
		echo "------------------------------------------------------------------------------"
		echo -e "\e[1;36mBuild $COUNT of $TOTAL\e[m -- $(date '+%F %R:%S')"
		echo -e "\e[1m./configure $o\e[m"
		echo
		git clean -xdfq
		autoreconf --install >& /dev/null
		./configure --quiet --disable-dependency-tracking $o CC="$c"
		sed -i 's/m4 po intl doc contrib/intl/' Makefile
		sed -i 's/\<cru\>/cr/' imap/Makefile
		if make -s; then
			log_success "Build succeeded"
			: $((SUCCESS++))
		else
			log_error "Build failed"
		fi
		: $((COUNT++))
	done
done

: $((COUNT--))

git clean -xdfq
popd >& /dev/null

if [ $SUCCESS = $COUNT ]; then
	log_success "Success: $SUCCESS/$COUNT builds succeeded"
else
	log_error "Only: $SUCCESS/$COUNT builds succeeded"
fi
date

