. /etc/profile
#export http_proxy=http://127.0.0.1:8000
#export https_proxy=http://127.0.0.1:8000
export EDITOR=vim
export BROWSER=chromium
#PATH=$PATH:
eval `dircolors ~/.config/dir_colors`

#man color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PAGER="less -isrf"

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

service () {
    sudo /etc/rc.d/$1 $2
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


alias p='pacman'
alias y='packer'
alias pi='packer -S'
alias pli='sudo pacman -U'
alias pud='sudo pacman -Syu'
alias pd='sudo pacman -Sw'
alias pp='sudo pacman -Rcsn'
alias psi='packer -Si'
alias pq='pacman -Qq'
alias pqi='pacman -Qi'
alias pql='pacman -Ql'
alias pqo='pacman -Qo'
alias pqd='pacman -Qdt'
alias pqe='pq -e'
alias pqm='pq -m'
alias prd='sudo pacman -Rdd'
alias pae='sudo pacman -D --asexplicit'
alias pad='sudo pacman -D --asdeps'
alias pcl='sudo pacman -Scc'

#alias opsqlite='cd ~/.mozilla/firefox && for s in `find -name "*.sqlite"`; { sqlite3 $s vacuum; }; cd -'
#alias cam='mencoder -oac faac -faacopts br=32 -ovc x264'
#alias cl='xclip -se cl -i'
#alias ncc='nc db-oped-dev64.db01 8001'
#alias wvd='sudo wvdial -C ~/.wvdialrc &'

alias h=history
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
alias pyweb='python2 -m SimpleHTTPServer 9999'
alias pyweb2='SimpleHTTPServerWithUpload.py 9999'
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
alias rmpwd='rm -r `pwd`;cd ..'
alias wpa='sudo wpa_supplicant -B -Dwext -i wlan0 -c /etc/wpa_supplicant.conf;sudo dhcpcd wlan0'
alias bd='nohup ~/.config/bnac/bnac.py &>/dev/null &'
alias gcl='git clone'
alias gpu='time git push'
alias cpui='cpufreq-info'
alias voff='ossmix jack.int-speaker.mute ON'
alias von='ossmix jack.int-speaker.mute OFF'
