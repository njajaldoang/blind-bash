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


function kakkoii(){
clear
figlet -f small -t "      Yaddy Kakkoii" | lolcat
echo -e "              TELEGRAM : t.me/Crystalllz | Crypter"
echo -e "              ⚡MAGELANG ⚡PHREAKER ⚡| versi beta"
echo ""
echo "*****************************************************"
echo "*            Not Open Source @Crystalllz            *"
echo "*****************************************************"
echo "*                 AUTO CREATE YAML                  *"
echo "*                      Author                       *"
echo "*                Mas Triadzz Ganteng                *"
echo "* Telegram: t.me/Crystalllz | Github: Yaddy Kakkoii *"
echo "*                       1337                        *"
echo "*****************************************************"
echo ""
}

function bannerwrt(){
        clear
        echo -e "              Yaddy Kakkoii" | lolcat
        echo -e "              TELEGRAM : t.me/Crystalllz | Crypter"
        echo -e "              ⚡MAGELANG ⚡PHREAKER ⚡| versi beta"
        echo ""
        echo "*****************************************************"
        echo "*            Not Open Source @Crystalllz            *"
        echo "*****************************************************"
        echo "*                 AUTO CREATE YAML                  *"
        echo "*                      Author                       *"
        echo "*                Mas Triadzz Ganteng                *"
        echo "* Telegram: t.me/Crystalllz | Github: Yaddy Kakkoii *"
        echo "*                       1337                        *"
        echo "*****************************************************"
        echo ""
}

##########################################################
############ OPENWRT REQUIRED PACKAGE
##########################################################
packages=(
    "gcc"
    "git"
    "git-http"
    "modemmanager"
    "python3-pip"
    "bc"
    "screen"
    "adb"
    "httping"
    "lolcat"
    "jq"
)
check_openwrt() {
    local package="$1"
    if opkg list-installed | grep -q "^$package -"; then
        echo "$package sudah terpasang."
    else
        echo "$package belum terpasang. Menginstal $package..."
        opkg update && opkg install "$package"
        if [ $? -eq 0 ]; then
            echo "$package berhasil diinstal."
        else
            echo "Gagal menginstal $package."
        fi
    fi
}
download_packages_openwrt() {
    echo "Update dan instal paket"
    for pkg in "${packages[@]}"; do
        check_openwrt "$pkg"
    done
    sleep 1
}
#############################################################
############ TERMUX REQUIRED PACKAGE
##########################################################
pakettermux=(
    "git"
    "lzma"
    "python"
    "ossp-uuid"
    "curl"
    "bash"
    "libwebp"
    "ffmpeg"
    "imagemagick"
    "libarchive"
    "libandroid-wordexp"
    "wget"
    "nmap"
    "zip"
    "nmap"
    "jq"
    "bc"
    "screen"
    "vim"
    "httping"
    "gcc"
    "sshpass"
    "perl"
    "patchelf"
    "file"
    "clang"
)

check_termux() {
    local pakettermux="$1"
    if ls /data/data/com.termux/files/usr/bin | grep -q "^$pakettermux"; then
        echo "$pakettermux sudah terpasang.✓"
    else
        echo "$pakettermux belum terpasang. Menginstal $pakettermux..."
        apt install ${pakettermux} -y
        if [ $? -eq 0 ]; then
            echo "$pakettermux berhasil diinstal."
        else
            echo "Gagal menginstal $pakettermux."
        fi
    fi
}

download_packages_termux() {
    echo "Update dan instal paket"
    chmod -R 777 /data/data/com.termux/files/usr/etc/
    rm /data/data/com.termux/files/usr/etc/bash.bashrc
    pkg install bash
    pkg update && pkg upgrade
    for pkg in "${pakettermux[@]}"; do
        check_termux "$pkg"
    done
    pip install rich
    pip install rich-cli
    apt clean
    sleep 1
}

#############################################################
############ VPS REQUIRED PACKAGE
##########################################################
paketvps=(
    "wget"
    "nmap"
    "zip"
    "nmap"
    "jq"
    "bc"
    "screen"
    "vim"
    "httping"
    "gcc"
    "sshpass"
    "perl"
    "git"
)

check_vps() {
    local paketvps="$1"
    if ls /usr/bin | grep -q "^$paketvps"; then
        echo "$paketvps sudah terpasang.✓"
    else
        echo "$paketvps belum terpasang. Menginstal $package..."
        apt install ${paketvps} -y
        if [ $? -eq 0 ]; then
            echo "$paketvps berhasil diinstal."
        else
            echo "Gagal menginstal $paketvps."
        fi
    fi
}

download_packages_vps() {
    echo "Update dan instal paket"
    for pkg in "${paketvps[@]}"; do
        check_vps "$pkg"
    done
    sleep 1
}
#############################################################

trap ctrl_c INT

ctrl_c() {
    clear
    rm -f install.sh >/dev/null 2>&1
    rm -f build.sh >/dev/null 2>&1
    if [ -f build.sh ]; then rm -f build.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Penginstallan ip domain checker telah dibatalkan."
    exit 1
}

trap ctrl_cs SEGV

ctrl_cs() {
    clear
    rm -f core >/dev/null 2>&1
    rm -f install.sh >/dev/null 2>&1
    rm -f build.sh >/dev/null 2>&1
    if [ -f *core* ]; then rm -f *core*; fi
    if [ -f build.sh ]; then rm -f build.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Penginstallan ip domain checker telah dibatalkan."
    echo -e "Mau Ngapain lu su , raimu asu !."
    # ntar tambah README NULL DI SINI
    exit 1
}

echo -e "\n\n${CLWhite} Sedang Menjalankan script.${CLYellow} Mohon Tunggu.."
echo -e "${CLWhite} Pastikan Koneksi Internet Lancar\n\n"

instal_nodejs_termux(){
    echo "Menginstall Node_Modules"
    echo ""
    sleep 3
    pkg update && pkg upgrade -y
    pkg install nodejs -y
    ln -s ${folder_bin}nodejs ${folder_bin}node
    npm install -g bash-obfuscate
    apt install ossp-uuid -y
    apt install coreutils -y
    apt install xz-utils -y
    apt install binutils -y
    apt install ncurses-utils -y
    apt install yarn -y
    yarn install
    #npm start
    #ncurses utils hanya untuk termux, cara install node js jg beda dengan vps
    #yarn untuk termux cmdtest untuk vps
    node -v
    npm -v
    echo ""
}
instal_nodejs_vps(){
    apt update && apt upgrade -y
    apt install binutils -y
    apt install coreutils -y
    apt install xz-utils -y
    apt install npm nodejs -y
    ln -s ${vps_bin}nodejs ${vps_bin}node
    npm install -g bash-obfuscate
    apt install cmdtest -y
    apt install yarn -y
    yarn install
    node -v
    npm -v
}
# ============================================================
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
IDX="https://raw.githubusercontent.com/njajaldoang/1dra/main/"
# ============================================================
function makedirectory(){
    mkdir -p $HOME/.var
    mkdir -p $HOME/.var/local
    mkdir -p $HOME/.var/local/sbin
    mkdir -p $HOME/.var/local/backup
}
function checkdirectory(){
if [ -d $HOME/.var ]; then rm -rf $HOME/.var; fi
if [ ! -d $HOME/.var ]; then makedirectory; fi
}
# ============================================================
if [ ! -f $HOME/.var/local/sbin/spiner ]; then
    checkdirectory
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
else
    rm -rf $HOME/.var/local/sbin/spiner
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
fi
source $HOME/.var/local/sbin/spiner
# ============================================================
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
# ============================================================

folder_bin=$(which curl | sed 's/curl//g')
termux_bin="/data/data/com.termux/files/usr/bin/"
vps_bin="/usr/bin/"

function dpkg_query(){
    if [ $(dpkg-query -W -f='${Status}' shc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall shc, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        apt update && apt upgrade -y
        apt install shc
    elif [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall nodejs, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        if [[ -d ${termux_bin} ]]; then
            if [[ ! -f ${termux_bin}npm ]]; then
                instal_nodejs_termux
            fi
        else
            instal_nodejs_vps
        fi
    fi
}

#   br=xzz gzz=1dra gzt=stb

function fortermux(){
    if [[ -e ${termux_bin}gzz ]]; then rm -f ${termux_bin}gzz; fi
    if [[ ! -f ${termux_bin}gzz ]]; then
        wget -qO ${termux_bin}xzz "${IDX}src/termxz" && wget -qO ${termux_bin}brot "${IDX}src/termbrot" && wget -qO ${termux_bin}gzz "${IDX}src/termgaza" && wget -qO ${termux_bin}gzt "${IDX}src/termgstb" && chmod +x ${termux_bin}gzt && chmod +x ${termux_bin}gzz && chmod +x ${termux_bin}brot && chmod +x ${termux_bin}xzz && gzz src/termcekip > $PREFIX/bin/cekip && gzz src/termgetip > $PREFIX/bin/getip && gzz src/termscan > $PREFIX/bin/scan && xzz $PREFIX/bin/cekip > /dev/null 2>&1 && xzz $PREFIX/bin/getip > /dev/null 2>&1 && xzz $PREFIX/bin/scan > /dev/null 2>&1 && rm $PREFIX/bin/cekip~ && rm $PREFIX/bin/getip~ && rm $PREFIX/bin/scan~ && chmod +x ${termux_bin}cekip && chmod +x ${termux_bin}getip && chmod +x ${termux_bin}scan
    fi
}

function forvps(){
    if [[ ! -f ${vps_bin}lzmv ]]; then wget -qO ${vps_bin}lzmv "${IDX}src/vxz"; fi && if [[ -e ${vps_bin}gzz ]]; then rm -f ${vps_bin}gzz; fi
    if [[ ! -f ${vps_bin}gzz ]]; then
        wget -qO ${vps_bin}gzz "${IDX}src/gaza" && wget -qO ${vps_bin}gzt "${IDX}src/gazat" && chmod +x ${vps_bin}gzt && chmod +x ${vps_bin}gzz && gzz src/termcekip > /usr/bin/cekip && gzz src/termgetip > /usr/bin/getip && gzz src/termscan > /usr/bin/scan && lzmv /usr/bin/cekip > /dev/null 2>&1 && lzmv /usr/bin/getip > /dev/null 2>&1 && lzmv /usr/bin/scan > /dev/null 2>&1 && rm /usr/bin/cekip~ && rm /usr/bin/getip~ && rm /usr/bin/scan~ && chmod +x ${vps_bin}cekip && chmod +x ${vps_bin}getip && chmod +x ${vps_bin}scan
    fi
}

if [[ "$folder_bin" = "$termux_bin" ]]; then
    kakkoii
    echo "hai user termux"
    if ! command -v which &> /dev/null; then apt install which -y; fi && if ! which gawk &> /dev/null; then apt install gawk; fi
    type -P tput 1>/dev/null
    [ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
    dpkg_query
    download_packages_termux
    echo -e "\n\n⌛please wait until finish, dont interupt process..."
    fun_bar 'fortermux'
    echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
else
    if [[ -e /etc/openclash ]]; then
        bannerwrt
        echo "hai user openwrt"
        download_packages_openwrt
        echo -e "\n\n⌛please wait until finish, dont interupt process..."
        if [[ ! -f ${vps_bin}xzwrt ]]; then wget -qO ${vps_bin}xzwrt "${IDX}src/vxz"; fi && if [[ -e ${vps_bin}gzz ]]; then rm -f ${vps_bin}gzz; fi
        if [[ ! -f ${vps_bin}gzz ]]; then
            wget -qO ${vps_bin}gzz "${IDX}src/gazawrti" && wget -qO ${vps_bin}gzt "${IDX}src/gazawrty" && chmod +x ${vps_bin}gzt && chmod +x ${vps_bin}gzz && gzz src/cekipwrt > /usr/bin/cekip && gzz src/getipwrt > /usr/bin/getip && gzz src/scanwrt > /usr/bin/scan && xzwrt /usr/bin/cekip > /dev/null 2>&1 && xzwrt /usr/bin/getip > /dev/null 2>&1 && xzwrt /usr/bin/scan > /dev/null 2>&1 && rm /usr/bin/cekip~ && rm /usr/bin/getip~ && rm /usr/bin/scan~ && chmod +x ${vps_bin}cekip && chmod +x ${vps_bin}getip && chmod +x ${vps_bin}scan
        fi
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
    else
        kakkoii
        echo "hai user vps"
        if ! command -v which &> /dev/null; then apt install which -y; fi && if ! which gawk &> /dev/null; then apt install gawk; fi
        type -P tput 1>/dev/null
        [ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
        dpkg_query
        download_packages_vps
        echo -e "\n\n⌛please wait until finish, dont interupt process..."
        fun_bar 'forvps'
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
    fi
fi



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
  print " $FORCE_HYPERLINK must be set and be non-zero (this acts as a logic bypass) "
  if test -n "$FORCE_HYPERLINK"; then
    test "$FORCE_HYPERLINK" != 0
    return $?
    echo " Status = support Hyperlink "
    echo " is_tty = $is_tty "
  else
    echo " Status = not support Hyperlink "
    echo " is_tty = $is_tty "
  fi

  print "If stdout is not a tty, it doesn't support hyperlinks"
  is_tty || return 1

  print " Check DomTerm terminal emulator (domterm.org)"
  if test -n "$DOMTERM"; then
    print " Dom Terminal terdeteksi"
    return 0
  fi

  print " Check VTE-based terminals above v0.50 (Gnome Terminal, Guake, ROXTerm, etc)"
  if test -n "$VTE_VERSION"; then
    print " Gnome Terminal terdeteksi"
    test $VTE_VERSION -ge 5000
    return $?
  fi

  print " If $TERM_PROGRAM is set, these terminals support hyperlinks"
  case "$TERM_PROGRAM" in
    Hyper|iTerm.app|terminology|WezTerm) return 0 ;;
  esac

  print " kitty supports hyperlinks"
  if test "$TERM" = xterm-kitty; then
    print " Xterm kitty terdeteksi"
    return 0
  fi

  print " Windows Terminal also supports hyperlinks"
  if test -n "$WT_SESSION"; then
    print " Windows Terminal terdeteksi"
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
  print "Tes $1: text, $2: url, $3: fallback mode"
  if supports_hyperlinks; then
    print "Result: Your Terminal Support Hyperlink"
    printf '\033]8;;%s\033\\%s\033]8;;\033\\\n' "$2" "$1"
    return
  else
    print "Result: Your Terminal Doesn't Support Hyperlink"
  fi

  case "$3" in
  --text) printf '%s\n' "$1" ;;
  --url|*) fmt_underline "$2" ;;
  esac
}


install_blind() {
  echo ""
  echo " Mulai Menginstall blind bash script "
  echo ""
  print " Prevent the cloned repository from having insecure permissions. Failing to do "
  print "  so causes compinit() calls to fail with <command not found: compdef> errors"
  print "  for users with insecure umasks (e.g., <002>, allowing group writability). Note"
  print "  that this will be ignored under Cygwin by default, as Windows ACLs take"
  print "  precedence over umasks except for filesystems mounted with option <noacl> "
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

check_path(){
    if [ -d /data/data/com.termux/files ]; then
        PATH=/data/data/com.termux/files/bin
        print "Your path: $PATH ✓"
    else
        PATH=/usr/bin
        print "Your path: $PATH ✓"
    fi
}

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

  print " Checking directory $PATH"
  check_path
  test -d "$PATH" && test -w "$PATH" && test -x "$PATH" || {
    #PATH=/data/data/com.termux/files/usr/bin
    test -d "$PATH" && test -w "$PATH" && test -x "$PATH" || {
      fmt_info "no such directory \$PATH !!"
      exit 1
    }
  }
sleep 2
  print " Checking file blind-bash.sh "
  check_file_utama
  test -x "$BLIND/blind-bash.sh" || test -f "$BLIND/blind-bash.sh" || {
    chmod -x "$BLIND/blind-bash.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file blind-bash.sh"
      echo "No such file blind-bash.sh in directory $BLIND"
      exit 1
    }
  }
sleep 2
  print " Checking file upgrade.sh "
  check_file_upgrade
  test -x "$BLIND/tools/upgrade.sh" || test -f "$BLIND/tools/upgrade.sh" || {
    chmod -x "$BLIND/tools/upgrade.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file upgrade.sh"
      echo "No such file upgrade.sh in directory $BLIND/tools"
      exit 1
    }
  }
sleep 2
  print " Checking file uninstall.sh "
  check_file_uninstall
  test -x "$BLIND/tools/uninstall.sh" || test -f "$BLIND/tools/uninstall.sh" || {
    chmod -x "$BLIND/tools/uninstall.sh"  >/dev/null 2>&1 || {
      fmt_info "cannot chmod file uninstall.sh"
      echo "No such file uninstall.sh in directory $BLIND/tools"
      exit 1
    }
  }
sleep 2

  print " Creating symbolic links"
  echo "Create symbolic link..."

  ln -s "$BLIND/blind-bash.sh" "$PATH/blind-bash" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/blind-bash.sh as $PATH/blind-bash"
    exit 1
  }
  ln -s "$BLIND/tools/upgrade.sh" "$PATH/.bb-upgrade" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/tools/upgrade.sh as $PATH/.bb-upgrade"
    exit 1
  }
  ln -s "$BLIND/tools/uninstall.sh" "$PATH/.bb-uninstall" >/dev/null 2>&1 || {
    fmt_info "cannot create symbolic link $BLIND/tools/uninstall.sh as $PATH/.bb-uninstall"
    exit 1
  }

  fmt_info "create symbolic link success ✓"
  sleep 3
}

print_success() {
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
  print_success
}

main $@