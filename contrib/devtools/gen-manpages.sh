#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

CONNEXD=${CONNEXD:-$BINDIR/connexd}
CONNEXCLI=${CONNEXCLI:-$BINDIR/connex-cli}
CONNEXTX=${CONNEXTX:-$BINDIR/connex-tx}
CONNEXQT=${CONNEXQT:-$BINDIR/qt/connex-qt}

[ ! -x $CONNEXD ] && echo "$CONNEXD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
CNXVER=($($CONNEXCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for connexd if --version-string is not set,
# but has different outcomes for connex-qt and connex-cli.
echo "[COPYRIGHT]" > footer.h2m
$CONNEXD --version | sed -n '1!p' >> footer.h2m

for cmd in $CONNEXD $CONNEXCLI $CONNEXTX $CONNEXQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${CNXVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${CNXVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
