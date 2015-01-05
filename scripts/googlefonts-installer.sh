#!/bin/bash
#
# written by Simon <simonjwiles@gmail.com>
# inspired by a script written by Michalis Georgiou <mechmg93@gmail.com>
#   and modified by Andrew http://www.webupd8.org <andrew@webupd8.org>,
#   described at
#   http://www.webupd8.org/2011/01/automatically-install-all-google-web.html
#
#  (but completely re-written)
#

HGROOT="https://googlefontdirectory.googlecode.com/hg/";
FONTDIR="/usr/share/fonts/truetype/google-fonts";

set -e;

exists() { which "$1" &> /dev/null ; }

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (i.e. with sudo)!" 1>&2;
    exit 1;
fi

if ! exists hg ; then
    echo "Mercurial is required (hint: sudo apt-get install mercurial)!" 1>&2;
    exit 1;
fi

mkdir -p "$FONTDIR";

TMPDIR=$(mktemp -d);
trap 'rm -rf "$TMPDIR"' EXIT INT QUIT TERM;

echo -n "Getting data from GoogleCode Repository... "
hg clone $HGROOT $TMPDIR > /dev/null;
if [ $? != 0 ]; then
    echo "Couldn't get data from GoogleCode Repository!  Aborting!" 1>&2;
    exit 1;
fi
echo "done!"

echo -n "Installing fonts... "
find $TMPDIR/ -name '*.ttf' -exec install -m644 {} "$FONTDIR" \;
echo "done!"

echo "Updating font cache... "
fc-cache -fvs "$FONTDIR";

echo "All done!"
