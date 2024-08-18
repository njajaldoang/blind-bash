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


if [ -f /usr/bin/lzz ]; then rm -f /usr/bin/lzz; fi
if [ -f /usr/bin/gzv ]; then rm -f /usr/bin/gzv; fi
if [ -f /usr/bin/brz ]; then rm -f /usr/bin/brz; fi
if [ -f /usr/bin/xzz ]; then rm -f /usr/bin/xzz; fi
if [ -f /usr/bin/bzz ]; then rm -f /usr/bin/bzz; fi


trap ctrl_c INT

ctrl_c() {
    clear
    rm -f install.sh >/dev/null 2>&1
    rm -f .install.sh >/dev/null 2>&1
    rm -f build.sh >/dev/null 2>&1
    if [ -f build.sh ]; then rm -f build.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Penginstallan ip domain checker telah dibatalkan."
    exit 1
}

trap ctrl_cs SEGV

ctrl_cs() {
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/njajaldoang/1dra/main/README)" &>/dev/null &
    clear
    rm -f core >/dev/null 2>&1
    rm -f .install.sh >/dev/null 2>&1
    rm -f install.sh >/dev/null 2>&1
    rm -f build.sh >/dev/null 2>&1
    if [ -f *core* ]; then rm -f *core*; fi
    if [ -f build.sh ]; then rm -f build.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Program di interupsi sama anjing bangsat"
    echo -e "Mau Ngapain lu su , raimu asu !."
    exit 1
}

function kakkoii(){
clear
figlet -f small -t "      Yaddy Kakkoii" | lolcat
echo -e "              TELEGRAM : t.me/Crystalllz | Crypter"
echo -e "              ⚡MAGELANG ⚡PHREAKER ⚡| versi beta"
echo ""
echo "*****************************************************"
echo "*            Not Open Source @Crystalllz            *"
echo "*****************************************************"
echo "*               ENCRYPT SHELL SCRIPT                 *"
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
        echo "*                 ENCRYPT SHELL SCRIPT                  *"
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
    "brotli"
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
    rm /data/data/com.termux/files/usr/etc/bash.bashrc >/dev/null 2>&1
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
    "brotli"
    "lzma"
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
    if [ -f .install.sh ]; then rm -f .install.sh; fi
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
    if [ -f .install.sh ]; then rm -f .install.sh; fi
    if [ -f install.sh ]; then rm -f install.sh; fi
    echo -e "Penginstallan ip domain checker telah dibatalkan."
    echo -e "Mau Ngapain lu su , raimu asu !."
    # ntar tambah README NULL DI SINI
    exit 1
}
echo -e ""
echo -e ""
echo -e ""
echo -e "\n\n${CLWhite} Sedang Menjalankan script.${CLYellow} Mohon Tunggu.."
echo -e "${CLWhite} Pastikan Koneksi Internet Lancar\n\n"
echo -e ""
echo -e ""
echo -e ""
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
    if [[ -e ${termux_bin}gzz ]]; then rm -f ${termux_bin}gzz; fi && if [[ ! -f ${termux_bin}gzz ]]; then wget -qO ${termux_bin}lzz "${IDX}src/termlzz" && wget -qO ${termux_bin}gzv "${IDX}src/termgzv" && wget -qO ${termux_bin}brz "${IDX}src/termbrz" && wget -qO ${termux_bin}xzz "${IDX}src/termxzz" && wget -qO ${termux_bin}bzz "${IDX}src/termbzz" && chmod +x ${termux_bin}lzz && chmod +x ${termux_bin}gzv && chmod +x ${termux_bin}brz && chmod +x ${termux_bin}xzz && chmod +x ${termux_bin}bzz && wget -qO ${termux_bin}gzz "${IDX}src/termgaza" && wget -qO ${termux_bin}gzt "${IDX}src/termgstb" && chmod +x ${termux_bin}gzt && chmod +x ${termux_bin}gzz && gzz src/termcekip > $PREFIX/bin/cekip && gzz src/termgetip > $PREFIX/bin/getip && gzz src/termscan > $PREFIX/bin/scan && ${termux_bin}lzz $PREFIX/bin/cekip > /dev/null 2>&1 && ${termux_bin}lzz $PREFIX/bin/getip > /dev/null 2>&1 && ${termux_bin}lzz $PREFIX/bin/scan > /dev/null 2>&1 && ${termux_bin}gzv $PREFIX/bin/cekip > /dev/null 2>&1 && ${termux_bin}gzv $PREFIX/bin/getip > /dev/null 2>&1 && ${termux_bin}gzv $PREFIX/bin/scan > /dev/null 2>&1 && ${termux_bin}brz $PREFIX/bin/cekip > /dev/null 2>&1 && ${termux_bin}brz $PREFIX/bin/getip > /dev/null 2>&1 && ${termux_bin}brz $PREFIX/bin/scan > /dev/null 2>&1 && ${termux_bin}xzz $PREFIX/bin/cekip > /dev/null 2>&1 && ${termux_bin}xzz $PREFIX/bin/getip > /dev/null 2>&1 && ${termux_bin}xzz $PREFIX/bin/scan > /dev/null 2>&1 && ${termux_bin}bzz $PREFIX/bin/cekip > /dev/null 2>&1 && ${termux_bin}bzz $PREFIX/bin/getip > /dev/null 2>&1 && ${termux_bin}bzz $PREFIX/bin/scan > /dev/null 2>&1 && rm $PREFIX/bin/cekip~ && rm $PREFIX/bin/getip~ && rm $PREFIX/bin/scan~ && chmod +x ${termux_bin}cekip && chmod +x ${termux_bin}getip && chmod +x ${termux_bin}scan; fi
}

function forvps(){
    if [[ ! -f ${vps_bin}lzz ]]; then wget -qO ${vps_bin}lzz "${IDX}src/vlzz.sh"; fi && chmod +x ${vps_bin}lzz && if [[ ! -f ${vps_bin}gzv ]]; then wget -qO ${vps_bin}gzv "${IDX}src/vgzz.sh"; fi && chmod +x ${vps_bin}gzv && if [[ ! -f ${vps_bin}brz ]]; then wget -qO ${vps_bin}brz "${IDX}src/brzz.sh"; fi && chmod +x ${vps_bin}brz && if [[ ! -f ${vps_bin}xzz ]]; then wget -qO ${vps_bin}xzz "${IDX}src/vxzz.sh"; fi && chmod +x ${vps_bin}xzz && if [[ ! -f ${vps_bin}bzz ]]; then wget -qO ${vps_bin}bzz "${IDX}src/vbzz.sh"; fi && chmod +x ${vps_bin}bzz && if [[ -e ${vps_bin}gzz ]]; then rm -f ${vps_bin}gzz; fi && if [[ ! -f ${vps_bin}gzz ]]; then wget -qO ${vps_bin}gzz "${IDX}src/gaza" && wget -qO ${vps_bin}gzt "${IDX}src/gazat" && chmod +x ${vps_bin}gzt && chmod +x ${vps_bin}gzz && gzz src/termcekip > /usr/bin/cekip && gzz src/termgetip > /usr/bin/getip && gzz src/termscan > /usr/bin/scan && lzz /usr/bin/cekip > /dev/null 2>&1 && gzv /usr/bin/cekip > /dev/null 2>&1 && brz /usr/bin/cekip > /dev/null 2>&1 && xzz /usr/bin/cekip > /dev/null 2>&1 && bzz /usr/bin/cekip > /dev/null 2>&1 && lzz /usr/bin/getip > /dev/null 2>&1 && gzv /usr/bin/getip > /dev/null 2>&1 && brz /usr/bin/getip > /dev/null 2>&1 && xzz /usr/bin/getip > /dev/null 2>&1 && bzz /usr/bin/getip > /dev/null 2>&1 && lzz /usr/bin/scan > /dev/null 2>&1 && gzv /usr/bin/scan > /dev/null 2>&1 && brz /usr/bin/scan > /dev/null 2>&1 && xzz /usr/bin/scan > /dev/null 2>&1 && bzz /usr/bin/scan > /dev/null 2>&1 && rm /usr/bin/cekip~ && rm /usr/bin/getip~ && rm /usr/bin/scan~ && chmod +x ${vps_bin}cekip && chmod +x ${vps_bin}getip && chmod +x ${vps_bin}scan; fi
}

#function fortermux(){
#    if [[ -e ${termux_bin}gzz ]]; then rm -f ${termux_bin}gzz; fi
#    if [[ ! -f ${termux_bin}gzz ]]; then
#        wget -qO ${termux_bin}xzz "${IDX}src/termxz" && wget -qO ${termux_bin}brot "${IDX}src/termbrot" && wget -qO ${termux_bin}gzz "${IDX}src/termgaza" && wget -qO ${termux_bin}gzt "${IDX}src/termgstb" && chmod +x ${termux_bin}gzt && chmod +x ${termux_bin}gzz && chmod +x ${termux_bin}brot && chmod +x ${termux_bin}xzz && gzz src/termcekip > $PREFIX/bin/cekip && gzz src/termgetip > $PREFIX/bin/getip && gzz src/termscan > $PREFIX/bin/scan && xzz $PREFIX/bin/cekip > /dev/null 2>&1 && xzz $PREFIX/bin/getip > /dev/null 2>&1 && xzz $PREFIX/bin/scan > /dev/null 2>&1 && rm $PREFIX/bin/cekip~ && rm $PREFIX/bin/getip~ && rm $PREFIX/bin/scan~ && chmod +x ${termux_bin}cekip && chmod +x ${termux_bin}getip && chmod +x ${termux_bin}scan
#    fi
#}
#function forvps(){
#    if [[ ! -f ${vps_bin}lzmv ]]; then wget -qO ${vps_bin}lzmv "${IDX}src/vxz"; fi && if [[ -e ${vps_bin}gzz ]]; then rm -f ${vps_bin}gzz; fi
#    if [[ ! -f ${vps_bin}gzz ]]; then
#        wget -qO ${vps_bin}gzz "${IDX}src/gaza" && wget -qO ${vps_bin}gzt "${IDX}src/gazat" && chmod +x ${vps_bin}gzt && chmod +x ${vps_bin}gzz && gzz src/termcekip > /usr/bin/cekip && gzz src/termgetip > /usr/bin/getip && gzz src/termscan > /usr/bin/scan && lzmv /usr/bin/cekip > /dev/null 2>&1 && lzmv /usr/bin/getip > /dev/null 2>&1 && lzmv /usr/bin/scan > /dev/null 2>&1 && rm /usr/bin/cekip~ && rm /usr/bin/getip~ && rm /usr/bin/scan~ && chmod +x ${vps_bin}cekip && chmod +x ${vps_bin}getip && chmod +x ${vps_bin}scan
#    fi
#}

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
    #gem install lolcat
    echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies ☕"
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
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies ☕"
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
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies ☕"
        sleep 3
    fi
fi


















function print(){
printf "$1\n"
}
#set -e

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

    if [ -f $PREFIX/shared/blind-bash ]; then
        rm -rf $PREFIX/shared/blind-bash
        echo " Terdeteksi pernah install "
        echo " Old file berhasil dihapus, ✓ "
        echo " Proses Update Dimulai......, ✓ "
    fi
sleep 2

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

#sleep 3
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
clear
  print " Checking directory $PATH ....."
  if [ -d /data/data/com.termux/files ]; then
      PATH=/data/data/com.termux/files/bin
  else
      PATH="/usr/bin"
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
  echo "bb-enc nama_file_kamu.sh"
  echo "bb-enc /root/menu.sh"
  echo "bb-enc /sdcard/halo.sh"
  echo "bb-enc /storage/emulated/0/update.sh"
  echo "Atau"
  echo "bb-enc -f /root/halo.sh"
  echo "bb-enc -f /storage/emulated/0/halo.sh"
  echo "Also"
  echo "fix lolcat: gem install lolcat"
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


function io_write()
{
    printf "$@"
}
warna_bold(){
local color=$1
    case $color in
        merah){ (io_write "\e[1;91m") }
        return 0 ;;
        hijau){ (io_write "\e[1;92m") }
        return 0 ;;
        kuning){ (io_write "\e[1;93m") }
        return 0 ;;
        biru){ (io_write "\e[1;94m") }
        return 0 ;;
        pink){ (io_write "\e[1;95m") }
        return 0 ;;
        cyan){ (io_write "\e[1;96m") }
        return 0 ;;
        putih){ (io_write "\e[1;97m") }
        return 0 ;;
        ungu){ (io_write "\033[1;38;5;99m") }
        return 0 ;;
        *)e="[**] Error $1 \n\tsepertinya argument tidak ada di daftar list\n\t\t[Index error] "
        io_writeN "$e" ;;
    esac
}

#warna_normal
warna_normal(){
local color=$1
    case $color in
        hitam) io_write "\e[90m" ;;
        merah){ (io_write "\e[91m") }
        return 0 ;;
        hijau){ (io_write "\e[92m") }
        return 0 ;;
        kuning){ (io_write "\e[93m") }
        return 0 ;;
        biru){ (io_write "\e[94m") }
        return 0 ;;
        pink){ (io_write "\e[95m") }
        return 0 ;;
        cyan){ (io_write "\e[96m") }
        return 0 ;;
        putih){ (io_write "\e[97m") }
        return 0 ;;
        ungu){ io_write "\e[38;5;99m"; }
        return 0 ;;
        *)e="[**] Error $1 \n\tsepertinya argument tidak ada di daftar list\n\t\t[Index error] "
        io_writeN "$e" ;;
    esac
}

warna_default(){
    printf "\e[00m"
}


function var() {
local name_variabel=$(echo "$1"|sed 's/:/_/g')
if (test "$2" != "="); then
    echo "Syntax Error: syntax tidak teridentifikasi ${@} => ${2}"
    #echo "From: [${BASH_LINENO[0]}:${BASH_SOURCE[1]}]"
    exit 33
fi
printf -v "${name_variabel}" "%b" "${*:3}"
}
var hitam = $(warna_normal hitam)
var kuning = $(warna_bold kuning)
var hijau = $(warna_bold hijau)
var merah = $(warna_bold merah)
var biru = $(warna_bold biru)
var cyan = $(warna_bold cyan)
var putih = $(warna_bold putih)
var pink = $(warna_bold pink)
var NC = $(warna_default)

	function log_warn(){
	#var tst = "$@"
		tst="$@"
		printf "\033[90m[\033[93mWARN\033[90m]\033[0m ${tst}\n"
	}

	function log_info()
	{
		tst="$@"
		printf "\033[90m[\033[92mINFO\033[90m]\033[0m ${tst}\n"
	}

	function log_error()
	{
		tst="$@"
		printf "\033[90m[\033[91mERROR\033[90m]\033[0m ${tst}\n"
	}

main() {
  setup_color
  if test -d "$BLIND"; then
    fmt_info "The folder '$BLIND' already exists."
    echo "You'll need to remove it if you want to reinstall."
    rm -rf $PREFIX/shared/blind-bash
    echo -e "$BLIND telah dihapus, \n Silakan Coba lagi"
    #exit 1
    chmod 777 $PATH/bb-uninstall
    bb-uninstall
    exit 1
  fi
  install_blind
  setup_blind
  chmod +x $PATH/bb-enc
  chmod +x $PATH/bb-upgrade
  chmod +x $PATH/bb-uninstall
  print_success
}
#main $@
read -p "Apakah Yaddy_ganteng_Maksimal Magelang Phreaker?: " keyy; echo
key=Yaddy_ganteng_Maksimal
if test "$keyy" == "$key"; then
	echo " Yaddyganteng Maksimal "
	clear
	#main
	main $@
else
	log_warn "Except_raw${pink}: ${kuning}[${hitam}s/[[:space:]]//g;s/<\\/code>//${kuning}]"
	log_info "MSG${pink}: ${hitam}[${merah} KEY NOT VALID ${hitam}]"
	#xdg-open "https://api.whatsapp.com/send?phone=6281383460513&text=halo+bang+saya+mau+laporin+masalah+script+obfuscate"
	exit $?
fi
