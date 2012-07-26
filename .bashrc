. /etc/profile
#export http_proxy=http://127.0.0.1:8000
#export https_proxy=http://127.0.0.1:8000
export EDITOR=vim
export BROWSER=chromium
export PAGER='less -isrf'
eval `dircolors ~/.config/dir_colors`

#man color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

gq () {
    geeqie $* 2>/dev/null &
}

imgresize () {
    gm mogrify -resize $1x$2 $3
}

cry () {
    if [ "t$1" = "t-d" ]; then
        openssl enc -aes-256-cbc -d -in $2 -out $3
    else
        openssl enc -aes-256-cbc -e -in $1 -out $2
    fi
}

st () {
    nohup $* &>/dev/null &
}

c () {
    cd $1
    ls --color=auto
}

cpu () {
    sudo cpufreq-set -f $1
    sudo cpufreq-set -c 1 -f $1
}

zcd () {
    cd ~/.avfs`pwd`/$@#
}

zback () {
    cd $(pwd|sed -e 's|^.*\.avfs||g' -e 's|/[^/]*#$||g')
}

aftp () {
    cd /home/osily/.avfs/#ftp:$1
}

vmvfs () {
    uri=`pwd`
    echo $uri | grep '.avfs' &>/dev/null && cd
    convmvfs /mnt/fuse -o srcdir=$uri,icharset=gbk
    cd /mnt/fuse/
}

#atool
file_7z='\.apk\b|\.zip\b|\.rar\b|\.jar\b|\.deb\b|\.iso\b'

al () {
    if echo $* |grep -Pi $file_7z >/dev/null; then
        als $* -F 7z
    else
        als $*
    fi
}

a () {
    if echo $* |grep -Pi $file_7z >/dev/null; then
        apack $* -F 7z
    else
        apack $*
    fi
}

au () {
    if echo $* |grep -Pi $file_7z >/dev/null; then
        arepack $* -F 7z
    else
        arepack $*
    fi
}

x () {
    if echo $* |grep -Pi $file_7z >/dev/null; then
        aunpack $* -F 7z
    else
        aunpack $*
    fi
}

#end atool

mcat () {
    markdown $1 > /tmp/.html
    w3m /tmp/.html
}

wpa () {
    sudo ifconfig wlan0 up
    sudo wpa_supplicant -B -Dwext -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf$1
}

findx () {
    find -print0|xargs -0 $@
}

pqe () {
    pacman -Qg base base-devel|sed 's/.* //g'|sort -u > /tmp/.base.list
    pacman -Qqe|sort -u > /tmp/.all.list
    comm -13 /tmp/.base.list /tmp/.all.list
    rm /tmp/.base.list /tmp/.all.list
}

alias y='yaourt'
alias pi='y -S'
alias pli='y -U'
alias pud='y -Syu --aur'
alias psu='y -Su --aur'
alias pd='y -Sw'
alias pp='y -Rcsn'
alias psi='y -Si'
alias pq='y -Qq'
alias pqi='y -Qi'
alias pql='y -Ql'
alias pqo='y -Qo'
alias pqd='y -Qdt'
alias pqm='y -Qqm'
alias prd='y -Rdd'
alias pae='y -D --asexplicit'
alias pad='y -D --asdeps'
alias pcl='y -Scc'

#alias voff='ossmix jack.int-speaker.mute ON'
#alias von='ossmix jack.int-speaker.mute OFF'
alias opsqlite='cd ~/.mozilla/firefox && for s in `find -name "*.sqlite"`; { sqlite3 $s vacuum; }; cd -'
alias h='history'
alias l='ls -F --color=auto'
alias lsd='l -d *(-/DN)'
alias ll='l -l --time-style=long-iso'
alias la='l -A'
alias lla='ll -A'
alias llh='ll -h'
alias grep='grep --color=auto'
alias rd='rmdir'
alias md='mkdir'
alias v='vim'
alias sv='sudo vim'
alias py='python2'
alias info='info --vi-keys'
alias s='sudo'
alias hd='hexdump -C'
alias le="$PAGER"
alias sm='sudo mount'
alias u='sudo umount'
alias fu='fusermount -u'
alias dh='df -hT'
alias pyweb='SimpleHTTPServerWithUpload.py 9999'
alias ucat='iconv -f gbk -t utf-8 -c'
alias gcat='iconv -f utf-8 -t gbk -c'
alias dub='du -sbh'
alias psg='ps aux|grep'
alias pst='pstree'
alias kigp='kill $(pgrep -f proxy.py)'
alias mt='top -u osily'
alias ctime='time cat'
alias ck='sudo ckermit ~/.kermrc -c'
alias fumnt='fu /mnt/fuse/'
alias ma='mountavfs'
alias ua='umountavfs'
alias lg='luit -encoding gbk'
alias wi='which'
alias rmpwd='rm -r "`pwd`";cd ..'
alias bd='nohup ~/.config/bnac/bnac.py &>/dev/null &'
alias gcl='git clone'
alias gpu='time git push'
alias cpui='cpufreq-info'
alias gmbox='python2 /usr/share/gmbox-gtk/gmbox-gtk.py'
alias cl='xclip -se cl -i'
alias gi='LANG=zh_CN.UTF-8 gimp &>/dev/null &'
alias ledon='sudo sh -c "echo 255 > /sys/class/leds/tpacpi::thinklight/brightness"'
alias ledoff='sudo sh -c "echo 0 > /sys/class/leds/tpacpi::thinklight/brightness"'
alias lid_close='xset dpms force off'
alias wvd='sudo wvdial -C ~/.wvdialrc'
alias src='sudo rc.d'
alias vm='vifm'
alias find0='find -print0'
alias xargs0='xargs -0'
alias findg='find|grep -P'

