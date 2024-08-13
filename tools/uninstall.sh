#!/bin/bash

USER=${USER:-$(id -u -n)}
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
HOME="${HOME:-$(eval echo ~$USER)}"

if [ -d /data/data/com.termux/files ]; then
    PREFIX=/data/data/com.termux/files/usr
else
    PREFIX=/usr
fi

test -d "$PREFIX" && test -w "$PREFIX" && test -x "$PREFIX" || test -d /data/data/com.termux/files/usr && test -w /data/data/com.termux/files/usr && test -x /data/data/com.termux/files/usr || {
  mkdir "$PREFIX" >/dev/null 2>&1
}

test -d "$PREFIX/shared" && test -w "$PREFIX/shared" && test -x "$PREFIX/shared" || {
  mkdir "$PREFIX/shared" >/dev/null 2>&1
}

read -r -p "Are you sure you want to remove Blind Bash? [Y/n] " confirmation
if test "$confirmation" != y && test "$confirmation" != Y; then
  echo "Uninstall cancelled"
  exit
fi

if command -v "bb-enc" >/dev/null 2>&1; then
  if test -f `command -v "bb-enc"` || test -x `command -v "bb-enc"`; then
    echo "Removing `command -v 'bb-enc'`"
    rm -rf `command -v "bb-enc"` >/dev/null 2>&1 || rm -rf `command -v "bb-enc"` >/dev/null 2>&1
  fi
fi
if command -v "bb-upgrade" >/dev/null 2>&1; then
  if test -f `command -v "bb-upgrade"` || test -x `command -v "bb-upgrade"`; then
    echo "Removing `command -v 'bb-upgrade'`"
    rm -rf `command -v "bb-upgrade"` >/dev/null 2>&1 || rm -rf `command -v "bb-upgrade"` >/dev/null 2>&1
  fi
fi
if command -v "bb-uninstall" >/dev/null 2>&1; then
  if test -f `command -v "bb-uninstall"` || test -x `command -v "bb-uninstall"`; then
    echo "Removing `command -v 'bb-uninstall'`"
    rm -rf `command -v "bb-uninstall"` >/dev/null 2>&1 || rm -rf `command -v "bb-uninstall"` >/dev/null 2>&1
  fi
fi
if test -d $PREFIX/shared/blind-bash; then
  rm -rf $PREFIX/shared/blind-bash >/dev/null 2>&1 || rm -rf $PREFIX/shared/blind-bash >/dev/null 2>&1
  echo "Removing $PREFIX/shared/blind-bash"
fi

if test -d $PREFIX/shared/bb-uninstall; then
  rm -rf $PREFIX/shared/bb-uninstall >/dev/null 2>&1 || rm -rf $PREFIX/shared/bb-update >/dev/null 2>&1
  echo "Removing $PREFIX/shared/bb-uninstall"
fi

if test -d $PREFIX/shared/bb-upgrade; then
  rm -rf $PREFIX/shared/bb-upgrade >/dev/null 2>&1 || rm -rf $PREFIX/shared/bb-update >/dev/null 2>&1
  echo "Removing $PREFIX/shared/bb-upgrade"
fi


if test -f $HOME/.config/.bb-update || test -x $HOME/.config/.bb-update; then
  rm -rf $HOME/.config/.bb-update >/dev/null 2>&1 || rm -rf $HOME/.config/.bb-update >/dev/null 2>&1
fi


echo "Thanks for trying out Blind Bash. It's been uninstalled."

exit
