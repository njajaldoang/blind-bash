#!/bin/bash
CLBlack="\e[0;30m"
CLRed="\e[0;31m"
CLGreen="\e[0;32m"
CLYellow="\e[0;33m"
CLBlue="\e[0;34m"
CLPurple="\e[0;35m"
CLCyan="\e[0;36m"
CLWhite="\e[0;37m"

BGBlack="\e[40m"
BGRed="\e[41m"
BGGreen="\e[42m"
BGYellow="\e[43m"
BGBlue="\e[44m"
BGPurple="\e[45m"
BGCyan="\e[46m"
BGWhite="\e[47m"

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

tyblue='\e[1;36m'
NC='\e[0m'

b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";c="\033[35;1m";u="\033[36;1m"
k="\033[33;1m";n="\033[00m"


if [ -d /data/data/com.termux/files ]; then
    wget -q https://raw.githubusercontent.com/njajaldoang/blind-bash/main/build.sh && chmod +x build.sh && ./build.sh && rm build.sh
else
    wget -q https://raw.githubusercontent.com/njajaldoang/blind-bash/main/buildvps.sh && chmod +x buildvps.sh && ./buildvps.sh && rm buildvps.sh
fi

trap ctrl_c INT

ctrl_c() {
    clear
    rm -f install.sh >/dev/null 2>&1
    rm -f build.sh >/dev/null 2>&1
    if [ -f build.sh ]; then rm -f build.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Penginstallan shell encrypter telah dibatalkan."
    exit 1
}

function print(){
printf "$1\n"
}
set -e

USER=${USER:-$(id -u -n)}

if [ -d /data/data/com.termux/files ]; then
    echo " Kamu user = Termux "
    PREFIX=/data/data/com.termux/files/usr
    test -d "$PREFIX" && test -w "$PREFIX" && test -x "$PREFIX" || test -d /data/data/com.termux/files/usr && test -w /data/data/com.termux/files/usr && test -x /data/data/com.termux/files/usr || { mkdir "/data/data/com.termux/files/usr" >/dev/null 2>&1; }
else
    echo " Kamu user = Vps "
    PREFIX=/usr
    test -d "$PREFIX" && test -w "$PREFIX" && test -x "$PREFIX" || test -d /usr && test -w /usr && test -x /usr || { mkdir "/usr" >/dev/null 2>&1; }
fi

echo " PREFIX = $PREFIX "
sleep 1
test -d "$PREFIX/shared" && test -w "$PREFIX/shared" && test -x "$PREFIX/shared" || {
  mkdir "$PREFIX/shared" >/dev/null 2>&1
}

BLIND="${BLIND:-$PREFIX/shared/blind-bash}"
REPO=${REPO:-njajaldoang/blind-bash}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-main}

echo " BLIND = $BLIND "
echo " REPO = $REPO "
echo " REMOTE = $REMOTE "
echo " BRANCH = $BRANCH "

sleep 3
clear

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


install_blind() {
  echo ""
  print " Prevent the cloned repository from having insecure permissions. Failing to do "
  print "  so causes compinit() calls to fail with <command not found: compdef> errors"
  print "  for users with insecure umasks (e.g., <002>, allowing group writability). Note"
  print "  that this will be ignored under Cygwin by default, as Windows ACLs take"
  print "  precedence over umasks except for filesystems mounted with option <noacl> "
  sleep 1
  echo ""
  echo " Mulai Menginstall blind bash script "
  sleep 3
  clear
  umask g-w,o-w

  echo "Cloning Blind Bash (blind-bash)..."

  ostype=$(uname)
  if [ -z "${ostype%CYGWIN*}" ] && git --version | grep -Eq 'msysgit|windows'; then
    fmt_info "Windows/MSYS Git is not supported on Cygwin"
    fmt_info "Make sure the Cygwin git package is installed and is first on the \$PATH"
    exit 1
  fi

  # Manual clone with git config options to support git < v1.7.2
  git init --quiet "$BLIND" && cd "$BLIND" \
  && git config core.eol lf \
  && git config core.autocrlf false \
  && git config fsck.zeroPaddedFilemode ignore \
  && git config fetch.fsck.zeroPaddedFilemode ignore \
  && git config receive.fsck.zeroPaddedFilemode ignore \
  && git config blind-bash.remote origin \
  && git config blind-bash.branch "$BRANCH" \
  && git remote add origin "$REMOTE" \
  && git fetch --depth=1 origin \
  && git checkout -b "$BRANCH" "origin/$BRANCH" || {
    test ! -d "$BLIND" || {
      cd - >/dev/null 2>&1
      rm -rf "$BLIND" >/dev/null 2>&1 || rm -rf "$BLIND" >/dev/null 2>&1
    }
    fmt_info "git clone of blind-bash repo failed"
    exit 1
  }
  # Exit installation directory
  cd - >/dev/null 2>&1

  fmt_info "git clone of blind-bash repo success"
}

setup_blind() {
clear

check_file_utama(){
    if [ -f $BLIND/blind-bash.sh ]; then
        chmod -x "$BLIND/blind-bash.sh"
        print "Your file: $BLIND/blind-bash.sh ✓"
    else
        echo "file blind-bash.sh in $BLIND not Found"
    fi
}

check_file_upgrade(){
    if [ -f $BLIND/tools/upgrade.sh ]; then
        chmod -x "$BLIND/tools/upgrade.sh"
        print "Your file: $BLIND/tools/upgrade.sh ✓"
    else
        echo "file upgrade.sh in $BLIND/tools/ not Found"
    fi
}

check_file_uninstall(){
    if [ -f $BLIND/tools/upgrade.sh ]; then
        chmod -x "$BLIND/tools/uninstall.sh"
        print "Your file: $BLIND/tools/uninstall.sh ✓"
    else
        echo "file uninstall.sh in $BLIND/tools/ not Found"
    fi
}

  print " Checking directory $PATH ....."
  if [ -d /data/data/com.termux/files ]; then
      PATH=/data/data/com.termux/files/bin
  else
      PATH=/usr/bin
  fi
  print "Your path: $PATH ✓"
  PATH="$PREFIX/bin"
sleep 1
  print " Checking file blind-bash.sh "
  check_file_utama
  test -x "$BLIND/blind-bash.sh" || test -f "$BLIND/blind-bash.sh" || {
    chmod -x "$BLIND/blind-bash.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file blind-bash.sh"
      echo "No such file blind-bash.sh in directory $BLIND"
      exit 1
    }
  }
sleep 1
  print " Checking file upgrade.sh "
  check_file_upgrade
  test -x "$BLIND/tools/upgrade.sh" || test -f "$BLIND/tools/upgrade.sh" || {
    chmod -x "$BLIND/tools/upgrade.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file upgrade.sh"
      echo "No such file upgrade.sh in directory $BLIND/tools"
      exit 1
    }
  }
sleep 1
  print " Checking file uninstall.sh "
  check_file_uninstall
  test -x "$BLIND/tools/uninstall.sh" || test -f "$BLIND/tools/uninstall.sh" || {
    chmod -x "$BLIND/tools/uninstall.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file uninstall.sh"
      echo "No such file uninstall.sh in directory $BLIND/tools"
      exit 1
    }
  }
sleep 1

  echo "Create symbolic link..."

  ln -s "$BLIND/blind-bash.sh" "$PATH/bb-enc" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/blind-bash.sh as $PATH/bb-enc"
    exit 1
  }
  
  fmt_info "create symbolic link $BLIND/blind-bash.sh as $PATH/bb-enc success ✓"

  ln -s "$BLIND/tools/upgrade.sh" "$PATH/bb-upgrade" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/tools/upgrade.sh as $PATH/bb-upgrade"
    exit 1
  }
  
  fmt_info "create symbolic link $BLIND/tools/upgrade.sh as $PATH/bb-upgrade success ✓"

  ln -s "$BLIND/tools/uninstall.sh" "$PATH/bb-uninstall" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/tools/uninstall.sh as $PATH/bb-uninstall"
    exit 1
  }

  fmt_info "create symbolic link $BLIND/tools/uninstall.sh as $PATH/bb-uninstall success ✓"
  
  fmt_info "create symbolic link success kabeh ✓"
  sleep 3
}

message="Hooray! Blind Bash has been installed 😁!"

print_success() {
  chmod 777 $PATH/bb-enc
  chmod 777 $PATH/bb-upgrade
  chmod 777 $PATH/bb-uninstall
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
  echo "bb-enc -v"
  echo "bb-enc -f /root/halo.sh"
  echo "bb-enc -f /storage/emulated/0/halo.sh"
  echo ""
  chmod +x $PATH/bb-enc
  chmod +x $PATH/bb-upgrade
  chmod +x $PATH/bb-uninstall
  sleep 2
  chmod 777 $PATH/bb-enc
  chmod 777 $PATH/bb-upgrade
  chmod 777 $PATH/bb-uninstall
#bb-enc --uninstall
#bb-enc --upgrade
}

main() {
  setup_color
  if test -d "$BLIND"; then
    fmt_info "The folder '$BLIND' already exists."
    echo "You'll need to remove it if you want to reinstall."
    exit 1
  fi
  install_blind
  setup_blind
  chmod +x $PATH/bb-enc
  chmod +x $PATH/bb-upgrade
  chmod +x $PATH/bb-uninstall
  print_success
}

main $@
