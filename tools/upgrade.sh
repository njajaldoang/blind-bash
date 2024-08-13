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

BLIND=$PREFIX/shared/blind-bash

# Test directory '.config'
test -d "$HOME/.config" && test -w "$HOME/.config" && test -x "$HOME/.config" || {
  mkdir "$HOME/.config" >/dev/null 2>&1
}

# Settings for check upgrade
_blind_upgrade_current_epoch() {
  local sec=${EPOCHSECONDS-}
  test $sec || printf -v sec '%(%s)T' -1 2>/dev/null || sec=$(command date +%s)
  echo $((sec / 60 / 60 / 24))
}

_blind_upgrade_update_timestamp() {
  echo "LAST_EPOCH=$(_blind_upgrade_current_epoch)" >| $HOME/.config/.bb-update
}

_blind_upgrade_update() {
  if test ! -f "$HOME/.config/.bb-update"; then
    # create ~/.osh-update
    _blind_upgrade_update_timestamp
    return 0
  fi

  local LAST_EPOCH
  . $HOME/.config/.bb-update
  if test ! $LAST_EPOCH; then
    _blind_upgrade_update_timestamp
    return 0
  fi

  # Default to the old behavior
  local epoch_expires=${UPDATE_BLIND_DAYS:-30}
  local epoch_elapsed=$(($(_blind_upgrade_current_epoch) - LAST_EPOCH))
  if ((epoch_elapsed <= epoch_expires)); then
    return 0
  fi

  _blind_upgrade_update_timestamp
}

# The test -t 1 check only works when the function is not called from
# a subshell (like in `$(...)` or `(...)`, so this hack redefines the
# function at the top level to always return false when stdout is not
# a tty.
if test -t 1; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# This function uses the logic from supports-hyperlinks[1][2], which is
# made by Kat Marchán (@zkat) and licensed under the Apache License 2.0.
# [1] https://github.com/zkat/supports-hyperlinks
# [2] https://crates.io/crates/supports-hyperlinks
#
# Copyright (c) 2021 Kat Marchán
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
supports_hyperlinks() {
  # $FORCE_HYPERLINK must be set and be non-zero (this acts as a logic bypass)
  if test -n "$FORCE_HYPERLINK"; then
    [ "$FORCE_HYPERLINK" != 0 ]
    return $?
  fi

  # If stdout is not a tty, it doesn't support hyperlinks
  is_tty || return 1

  # DomTerm terminal emulator (domterm.org)
  if test -n "$DOMTERM"; then
    return 0
  fi

  # VTE-based terminals above v0.50 (Gnome Terminal, Guake, ROXTerm, etc)
  if test -n "$VTE_VERSION"; then
    [ $VTE_VERSION -ge 5000 ]
    return $?
  fi

  # If $TERM_PROGRAM is set, these terminals support hyperlinks
  case "$TERM_PROGRAM" in
  Hyper|iTerm.app|terminology|WezTerm) return 0 ;;
  esac

  # kitty supports hyperlinks
  if [ "$TERM" = xterm-kitty ]; then
    return 0
  fi

  # Windows Terminal also supports hyperlinks
  if test -n "$WT_SESSION"; then
    return 0
  fi

  # Konsole supports hyperlinks, but it's an opt-in setting that can't be detected
  # if test -n "$KONSOLE_VERSION"; then
  #   return 0
  # fi

  return 1
}

setup_color() {
  # Only use colors if connected to a terminal
  if ! is_tty; then
    BOLD=""
    RESET=""
    return
  fi

  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
}

fmt_link() {
  # $1: text, $2: url, $3: fallback mode
  if supports_hyperlinks; then
    printf '\033]8;;%s\033\\%s\033]8;;\033\\\n' "$2" "$1"
    return
  fi

  case "$3" in
  --text) printf '%s\n' "$1" ;;
  --url|*) fmt_underline "$2" ;;
  esac
}

fmt_underline() {
  is_tty && printf '\033[4m%s\033[24m\033[1m' "$*" || printf '%s\n' "$*"
}

_blind_run_upgrade() {
  # Update upstream remote to ohmyzsh org
  git remote -v | while read remote url extra; do
    case "$url" in
    https://github.com/njajaldoang/blind-bash | https://github.com/njajaldoang/blind-bash.git)
      git remote set-url "$remote" "https://github.com/njajaldoang/blind-bash.git"
      break ;;
    git@github.com:njajaldoang/blind-bash | git@github.com:njajaldoang/blind-bash.git)
      git remote set-url "$remote" "git@github.com:njajaldoang/blind-bash.git"
      break ;;
    # Update out-of-date "unauthenticated git protocol on port 9418" to https
    git://github.com/njajaldoang/blind-bash | git://github.com/njajaldoang/blind-bash.git)
      git remote set-url "$remote" "https://github.com/njajaldoang/blind-bash.git"
      break ;;
    esac
  done

  # Set git-config values known to fix git errors
  # Line endings (#4069)
  git config core.eol lf
  git config core.autocrlf false
  # zeroPaddedFilemode fsck errors (#4963)
  git config fsck.zeroPaddedFilemode ignore
  git config fetch.fsck.zeroPaddedFilemode ignore
  git config receive.fsck.zeroPaddedFilemode ignore
  # autostash on rebase (#7172)
  resetAutoStash=$(git config --bool rebase.autoStash 2>/dev/null)
  git config rebase.autoStash true

  local ret=0

  # repository settings
  remote_repo="$(git config --local blind-bash.remote)"
  branch_repo="$(git config --local blind-bash.branch)"
  remote=${remote_repo:-origin}
  branch=${branch_repo:-master}

  # repository state
  last_head=$(git symbolic-ref --quiet --short HEAD || git rev-parse HEAD)
  # checkout update branch
  git checkout -q "$branch" -- || exit 1
  # branch commit before update (used in changelog)
  last_commit=$(git rev-parse "$branch")

  # Update blind-bash
  echo "Updating Blind Bash..."
  if LANG= git pull --quiet --rebase $remote $branch; then
    # Check if it was really updated or not
    if test "$(git rev-parse HEAD)" = "$last_commit"; then
      echo "Blind Bash is already at the latest version."
      _blind_upgrade_update
      exit
    else
      message="Hooray! Blind Bash has been updated!"
      # Update .bb-update
      _blind_upgrade_update_timestamp
      # Save the commit prior to updating
      git config blind-bash.lastVersion "$last_commit"
    fi
  fi
  print_success
}

print_success() {
  printf '%s\n' "${BOLD}${message}"
  printf '%s\n' '    __    ___           __      __               __'
  printf '%s\n' '   / /_  / (_)___  ____/ /     / /_  ____ ______/ /_'
  printf '%s\n' '  / __ \/ / / __ \/ __  /_____/ __ \/ __ `/ ___/ __ \'
  printf '%s\n' ' / /_/ / / / / / / /_/ /_____/ /_/ / /_/ (__  ) / / /'
  printf '%s\n\n' '/_.___/_/_/_/ /_/\__,_/     /_.___/\__,_/____/_/ /_/'
  printf >&2 '%s\n' "Contact me in:"
  printf >&2 '%s\n' "• Facebook : $(fmt_link 파자르김 https://facebook.com/fajarrkim)"
  printf >&2 '%s\n' "• Instagram: $(fmt_link @fajarkim_ https://instagram.com/fajarkim_)"
  printf >&2 '%s\n' "             $(fmt_link @fajarhacker_ https://instagram.com/fajarhacker_)"
  printf >&2 '%s\n' "• Twitter  : $(fmt_link @fajarkim_ https://twitter.com/fajarkim_)"
  printf >&2 '%s\n' "• Telegram : $(fmt_link @FajarThea https://t.me/FajarThea)"
  printf >&2 '%s\n' "• WhatsApp : $(fmt_link +6285659850910 https://wa.me/6285659850910)"
  printf >&2 '%s\n' "• YouTube  : $(fmt_link 'Fajar Hacker' https://youtube.com/@FajarHacker)"
  printf >&2 '%s\n' "• E-mail   : fajarrkim@gmail.com${RESET}"
}

main() {
  setup_color
  if test -d "$BLIND" && test -w "$BLIND" && test -x "$BLIND"; then
    cd "$BLIND"
    _blind_run_upgrade
  else
    _blind_run_upgrade
  fi
  cd - >/dev/null 2>&1
}

main $@
