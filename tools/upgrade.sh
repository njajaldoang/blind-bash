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

BLIND=$PREFIX/shared/blind-bash

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


lancar(){
  echo "Mantap Gaess"
  echo "Result: is_tty = true ✓"
}

zonk(){
  echo "Yahh.. malah zonk"
  echo "Result: is_tty = false !!"
}

echo "Menjalankan <Tes eksekusi> = test -t 1 "
if test -t 1; then
  is_tty() {
    true
  }
  lancar
  sleep 2
  clear
else
  is_tty() {
    false
  }
  zonk
  sleep 2
  clear
fi


supports_hyperlinks() {
  if test -n "$FORCE_HYPERLINK"; then
    test "$FORCE_HYPERLINK" != 0
    return $?
  fi
  sleep 2
  is_tty || return 1
  if test -n "$DOMTERM"; then
    return 0
  fi
  if test -n "$VTE_VERSION"; then
    test $VTE_VERSION -ge 5000
    return $?
  fi
  case "$TERM_PROGRAM" in
    Hyper|iTerm.app|terminology|WezTerm) return 0 ;;
  esac
  if test "$TERM" = xterm-kitty; then
    return 0
  fi
  if test -n "$WT_SESSION"; then
    return 0
  fi

  return 1
}

setup_color() {
  print " Hanya menggunakan warna kalau udah konek ke terminal"
  if ! is_tty; then
    zonk
    BOLD=""
    RESET=""
    return
  else
    lancar
    echo "Bisa Menggunakan Warna Bold ✓"
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
  fi
sleep 3
clear
}

fmt_info() {
  printf >&2 '%s%s\n' "${0##*/}: " "$@"
}

fmt_underline() {
  is_tty && printf '\033[4m%s\033[24m\033[1m' "$*" || printf '%s\n' "$*"
}

fmt_link() {
  if supports_hyperlinks; then
    printf '\033]8;;%s\033\\%s\033]8;;\033\\\n' "$2" "$1"
    return
  fi
  case "$3" in
  --text) printf '%s\n' "$1" ;;
  --url|*) fmt_underline "$2" ;;
  esac
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
  chmod 777 /usr/bin/bb-enc
  chmod 777 /usr/bin/bb-upgrade
  chmod 777 /usr/bin/bb-uninstall
  print_success
}

print_success() {
  chmod 777 /usr/bin/bb-enc
  chmod 777 /usr/bin/bb-upgrade
  chmod 777 /usr/bin/bb-uninstall
  chmod +x /usr/bin/bb-enc
  /usr/bin/bb-enc -v
  printf '%s\n' "${BOLD}${message}"
  printf '%s\n' "${BOLD}    __    ___           __      __               __"
  printf '%s\n' '   / /_  / (_)___  ____/ /     / /_  ____ ______/ /_'
  printf '%s\n' '  / __ \/ / / __ \/ __  /_____/ __ \/ __ `/ ___/ __ \'
  printf '%s\n' ' / /_/ / / / / / / /_/ /_____/ /_/ / /_/ (__  ) / / /'
  printf '%s\n' '/_.___/_/_/_/ /_/\__,_/     /_.___/\__,_/____/_/ /_/'
  printf '%s\n' '                       Has been installed!! :)'
  printf >&2 '%s\n' "Contact me in:"
  printf >&2 '%s\n' "• Telegram : $(fmt_link @Crystalllz https://t.me/Crystalllz)"
  printf >&2 '%s\n' "• WhatsApp : $(fmt_link +6281383460513 https://wa.me/6285659850910)"
  printf >&2 '%s\n' "• E-mail   : yadicakepp@gmail.com${RESET}"
  echo ""
  print "Contoh command < bb-enc -f halo.sh >"
  echo ""
  echo "bb-enc -f /root/halo.sh"
  echo "bb-enc -f /storage/emulated/0/halo.sh"
  echo ""
  sleep 2
  chmod 777 /usr/bin/bb-enc
  chmod 777 /usr/bin/bb-upgrade
  chmod 777 /usr/bin/bb-uninstall
#bb-enc --uninstall
#bb-enc --upgrade
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
