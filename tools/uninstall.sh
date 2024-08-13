#!/bin/bash
# Make sure important variables exist if not already defined
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"

# Test directory '/data/data/com.termux/files/usr'
test -d "$PREFIX" && test -w "$PREFIX" && test -x "$PREFIX" || test -d /data/data/com.termux/files/usr && test -w /data/data/com.termux/files/usr && test -x /data/data/com.termux/files/usr || {
  mkdir "/data/data/com.termux/files/usr" >/dev/null 2>&1
}

if [ -d /data/data/com.termux/files ]; then
    PREFIX=/data/data/com.termux/files/usr
else
    PREFIX=/usr
fi

# Test directory '/data/data/com.termux/files/usr/shared'
test -d "$PREFIX/shared" && test -w "$PREFIX/shared" && test -x "$PREFIX/shared" || {
  mkdir "$PREFIX/shared" >/dev/null 2>&1
}

read -r -p "Are you sure you want to remove Blind Bash? [Y/n] " confirmation
if test "$confirmation" != y && test "$confirmation" != Y; then
  echo "Uninstall cancelled"
  exit
fi

if command -v "blind-bash" >/dev/null 2>&1; then
  if test -f `command -v "blind-bash"` || test -x `command -v "blind-bash"`; then
    echo "Removing `command -v 'blind-bash'`"
    rm -rf `command -v "blind-bash"` >/dev/null 2>&1 || rm -rf `command -v "blind-bash"` >/dev/null 2>&1
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
  rm -rd $PREFIX/shared/blind-bash >/dev/null 2>&1 || rm -rd $PREFIX/shared/blind-bash >/dev/null 2>&1
  echo "Removing $PREFIX/shared/blind-bash"
fi
if test -f $HOME/.config/.bb-update || test -x $HOME/.config/.bb-update; then
  rm -rf $HOME/.config/.bb-update >/dev/null 2>&1 || rm -rf $HOME/.config/.bb-update >/dev/null 2>&1
fi

echo "Thanks for trying out Blind Bash. It's been uninstalled."

exit
