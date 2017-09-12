#zmodload zsh/datetime && local start_time=$EPOCHREALTIME

#{{{ 命令提示符、标题栏、任务栏样式
precmd() {
    # %{%F{cyan}%}
    # %n -- username
    # %{%F{green}%}
    # %M -- hostname
    # :
    # %{%F{red}%}
    # %(?..[%?]:) -- error code
    # %{%F{white}%}
    # %~ -- dir
    # $'\n' -- new line
    # %% -- %
    PROMPT="%{%F{cyan}%}%n@%{%F{green}%}%M:%{%F{red}%}%(?..[%?]:)%{%F{white}%}%~"$'\n'"%% "

    # 清空上次显示的命令
    # %30<..<内容%<< 从左截断
    # %~ 当前目录路径
    [[ $TERM == screen* ]] && print -Pn "\ek%30<..<%~%<<\e\\"
}

case $TERM {
    (screen*)
    preexec() {
        # \ek 起始
        # %30>..内容%<<  如果超过 30 个字符就从右截断
        # ${1/[\\\%]*/@@@} 截断 \ 和 % 之后的内容，避免出乱码输出
        # \e\\ 终止
        print -Pn "\ek%30>..>${1/[\\\%]*/@@@}%<<\e\\"
    }
    ;;

    (xterm*)
    preexec() {
        # \e]0;内容\a
        print -Pn "\e]0;%~$ ${1/[\\\%]*/@@@}\a"
    }
    ;;
}
#}}}


#{{{ 关于历史纪录的配置
# 历史纪录条目数量
export HISTSIZE=100000
# 注销后保存的历史纪录条目数量
export SAVEHIST=100000
# 历史纪录文件
export HISTFILE=~/.zhistory
# 多个 zsh 间分享历史纪录
setopt SHARE_HISTORY
# 如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
# 为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY
# 启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
# 相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
# 在命令前添加空格，不将此命令添加到纪录文件中
setopt HIST_IGNORE_SPACE
# 加强版通配符
setopt EXTENDED_GLOB
# 禁用终端响铃
unsetopt BEEP
#}}}

#{{{ 按键绑定
bindkey -v
bindkey "\e[1~"   beginning-of-line
bindkey "\e[2~"   insert-last-word
bindkey "\e[3~"   delete-char
bindkey "\e[4~"   end-of-line
bindkey "\e[5~"   backward-word
bindkey "\e[6~"   forward-word
bindkey "\e[7~"   beginning-of-line
bindkey "\e[8~"   end-of-line
bindkey "\e[A"    up-line-or-search
bindkey "\e[B"    down-line-or-search
bindkey "\e[C"    forward-char
bindkey "\e[D"    backward-char
bindkey "\eOH"    beginning-of-line
bindkey "\eOF"    end-of-line
bindkey "\e[H"    beginning-of-line
bindkey "\e[F"    end-of-line

bindkey "^p"      up-line-or-search
bindkey "^n"      down-line-or-search
bindkey "^r"      history-incremental-search-backward
bindkey "^a"      beginning-of-line
bindkey "^e"      end-of-line
bindkey "^f"      forward-word
bindkey "^b"      backward-word
bindkey "^k"      kill-line

# 用 vim 编辑命令行
autoload -U       edit-command-line
zle -N            edit-command-line
bindkey '^g'      edit-command-line

# 在命令前插入 sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    # 光标移动到行末
    zle end-of-line
}

zle -N sudo-command-line
bindkey '^y' sudo-command-line

# ctrl + h 退格
# ctrl + i tab
# ctrl + j 回车
# ctrl + k 删除之后字符
# ctrl + s 冻结
# ctrl + q 恢复
# ctrl + u 删除之前字符
# ctrl + y sudo
# 还没有用的 f m o t w x (h) (i) 
#}}}


#{{{ 自动补全
# 扩展路径
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

setopt AUTO_LIST
setopt AUTO_MENU
# 开启此选项，补全时会直接选中菜单项
# setopt MENU_COMPLETE
autoload -U compinit
compinit

_force_rehash() {
    ((CURRENT == 1)) && rehash
    return 1    # Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate

# 自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# 路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

# 彩色补全菜单
export ZLSCOLORS=$LS_COLORS
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# 错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# 补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# kill 补全
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# 空行(光标在行首)补全 "cd "
user-complete() {
    case $BUFFER {
        "" )                      
            # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;

        " " )
            BUFFER="!?"
            zle end-of-line
            zle expand-or-complete
            ;;

        * )
            zle expand-or-complete
            ;;
    }
}

zle -N user-complete
bindkey "\t" user-complete
##}}}


#{{{ 杂项
# 进入相应的路径时只要 cd ~xxx
hash -d mine='/mnt/c/mine'

# 加载函数
autoload -U zmv
autoload -U zrecompile

# 按照对应命令补全
compdef cwi=sudo
compdef vwi=sudo
compdef st=sudo
#}}}


#{{{ 和 zsh 无关的配置
export LANG=en_US.UTF-8
(($+USER)) || export USER=goreliu
(($+SHELL)) || export SHELL=/bin/zsh
umask 022

(($+TMUX == 0 && $+USE_TMUX)) && {
    (($+ATTACH_ONLY)) && {
        tmux a 2>/dev/null || {
            cd && exec tmux
        }
        exit
    }

    tmux new-window -c $PWD 2>/dev/null && exec tmux a
    exec tmux
}

alias h='history'
alias j='ls -F --color'
alias lsd='ls -F --color -d *(-/DN)'
alias ll='ls -F --color -l --time-style=long-iso'
alias la='ls -F --color -A'
alias lla='ls -F --color --time-style=long-iso -lA'
alias l='ls -F --color --time-style=long-iso -lh'
alias lsc='t=(*); echo $#t; unset t'
alias lscc='t=(* .*); echo $#t; unset t'
alias g='grep'
alias gv='grep -v'
alias rd='rmdir'
alias md='mkdir -p'
alias v='vim -p'
alias sv='sudo vim -p'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias info='info --vi-keys'
alias s='sudo'
alias hd='hexdump -C'
alias le='less -iRf'
alias dh='df -hT'
alias upf='droopy 8888'
alias dof='darkhttpd $PWD --port 8888'
alias ucat='iconv -f gb18030 -t utf-8 -c'
alias gcat='iconv -f utf-8 -t gb18030 -c'
alias u16cat='iconv -f utf-16 -t utf-8 -c'
alias dub='du -sbh'
alias dud='du --max-depth 1 -bh'
alias psa='ps aux'
alias psg='psa | grep -v grep | grep'
alias pk='pkill'
alias pk9='pkill -9'
alias ka='killall'
alias ka9='killall -9'
alias pst='pstree'
alias mt="top -u $USER"
alias ctime='time cat'
alias wi='which'
alias redir='rmdir **/*(/^F)'
alias cpui='grep MHz /proc/cpuinfo'
alias fng='find | grep -P'
alias e='print'
alias p='print'
alias pl='print -l'
alias pn='print -n'
alias pc='print -P'
alias f='file'
alias i='git'
alias ic='ifconfig'
alias m='man'
alias q='exit'
alias vd='vimdiff'
alias wl='wc -l'
alias frm='free -m'
alias d='tree'
alias gmc='gm convert'
alias jl='ll /dev | grep -E "(sd|mmcblk)"'
alias tf='tail -f'
alias pb='dlsource search'
alias pbg='dlsource download'
alias pbu='dlsource update'
alias hi='ifconfig 2>/dev/null | grep broadcast | cut -d" " -f10'
alias ,='percol'
alias ua='uname -a'
alias utf8_add_bom='sed -i "1s/^/\xEF\xBB\xBF/g"'
alias a='apack'
alias au='arepack'
alias x='aunpack'
alias al='als'
alias lc='lolcat'
alias sm='sudo mount'
alias um='sudo umount'
alias sf='neofetch'
alias vrc='vim ~/.zshrc; zc; . ~/.zshrc'
alias u='cd -'
alias up='uptime'
alias w='w -i'
alias dmg='dmesg'
alias b='date +"%Y-%m-%d %H:%M:%S (%u)"'
alias wd='w3m -dump'
alias fm='ranger'
alias di='colordiff'
alias we='wget'
alias tn='telnet'
alias calc='noglob calculate'
alias mmv='noglob zmv -W'
alias rpd='rm -rv $PWD && cd ..'
alias rpdf='rm -rvf $PWD && cd ..'
alias keepdir='touch .keep; chmod 400 .keep'
alias icmu='git commit -am update'
alias iu='git push'
alias icmuu='icmu && iu'
alias ipu='git pull'
alias uf='unfunction'
alias ti='time'
alias uu='. ~/.zshrc'
alias uuu='exec zsh'
alias zc='zrecompile ~/.zshrc ~/.zcompdump'
alias at='zmodload zsh/sched; sched'
alias aria='aria2c -c -s10 -k1M -x16 --enable-rpc=false'
alias runs='~/app/server/run'
alias dos2unix='sed -i "s/\r$//g"'
alias unix2dos='sed -i "s/$/\r/g"'
alias sshs='sudo /bin/sshd'
alias sshk='sudo killall sshd'
alias sort='LANG=C sort'
alias csc='wrun c:/Windows/Microsoft.NET/Framework64/v4.0.30319/csc.exe /utf8output /nologo'
# aliasend

if [[ -e /dev/lxss ]] {
    export PATH=/usr/bin
    alias z='wrun cmd /c'
    alias cmd='wrun cmd'
    alias se='sudo /bin/systemctl.py'
    alias ahk='wrun c:/mine/app/AutoHotkey/AutoHotkeyU32.exe'
    alias ahk64='wrun c:/mine/app/AutoHotkey/AutoHotkeyU64.exe'
    alias np='st wrun c:/mine/app/notepad++/notepad++.exe'
    alias di='st wrun c:/mine/app/WinMerge/WinMergeU.exe'
    alias mpv='st wrun c:/mine/app/mpv/mpv.exe'
    alias flve='wrun c:/mine/app/FLV_Extract/FLVExtractCL.exe'
    alias fm='tc'
    alias ipconfig='wrun ipconfig | ucat'
    alias tl='wrun tasklist'
    alias tlg='wrun tasklist | grep'
    alias netstat='wrun netstat'
    alias ps1='wrun powershell'
    alias pa='wrun c:/mine/app/0misc/bin/pclip.exe'
    alias msg="wrun msg $USER"
    alias cl='wrun clip'

    alias vm='wrun c:/Progra~1/Oracle/VirtualBox/VBoxManage.exe'
    alias vmlist='vm list vms; echo --RUNNING--; vm list runningvms'
    alias vmup='vm startvm archlinux --type headless'
    alias vmdown='vm controlvm archlinux savestate'
    alias vmpause='vm controlvm archlinux pasue'
    alias vmresume='vm controlvm archlinux resume'
    alias vmhalt='vm controlvm archlinux poweroff'

    tc() {
        local filename

        if [[ -d $1 ]] {
            cd $1
        } else {
            cd ${1:h}
            filename=${1:t}
        }

        st wrun c:/mine/app/totalcmd/Totalcmd.exe $(wrun)/$filename
        cd - >/dev/null
    }

    wsudo() {
        wrun cmd /C c:/mine/app/wsl-terminal/tools/runas.js $*
    }

    srun() {
        wsudo powershell -NoLogo -c "$*;pause"
    }

    disma() {
        srun Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
    }

    dismc() {
        srun Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
    }

    tk() {
        wrun taskkill /f /im $1.exe
    }

    st() {
        setsid $* </dev/null &>/dev/null
    }
} elif [[ $OSTYPE == *android* ]] {
    export SHELL=/data/data/com.termux/files/usr/bin/zsh
    alias search_cpu='zsh ~/.bin/search_cpu'
    alias cg='zsh ~/.bin/cg'
    alias vg='zsh ~/.bin/vg'
    alias n='zsh ~/.bin/n'
    alias chall='zsh ~/.bin/chall'
    alias renamex='zsh ~/.bin/renamex'
    alias dlsource='zsh ~/.bin/dlsource'
    alias qip='zsh ~/.bin/qip'
    alias rmdup='zsh ~/.bin/rmdup'
    alias dh='df 2>/dev/null'
    alias frm="free -m | sed 's/ \+/  /g'"
    alias pkill='busybox pkill'
    alias mt='top'
    alias chr='termux-chroot zsh'

    precmd() {
        PROMPT="%{%F{cyan}%}goreliu@%{%F{green}%}my-phone:%{%F{red}%}%(?..[%?]:)%{%F{white}%}%~"$'\n'"%% "
    }

    st() {
        ($* </dev/null &>/dev/null &)
    }
} else {
    alias smvb='sudo mount.vboxsf -o uid=1000,gid=1000,rw,dmode=700,fmode=600'
    alias se='sudo systemctl'
    alias jf='journalctl -f'

    st() {
        ($* </dev/null &>/dev/null &)
    }
}

path+=($HOME/.bin)
fpath+=($HOME/.bin)
export EDITOR=vim
export PAGER='less -irf'
export GREP_COLOR='40;33;01'
eval `dircolors $HOME/.dir_colors`

# man 颜色
export LESS_TERMCAP_mb=$'\E[01;31m'
# 标题和命令主体
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
# 命令参数
export LESS_TERMCAP_us=$'\E[04;36;4m'

imgresize() {
    gm mogrify -resize $1x$2 $3
}

cry() {
    if [[ $1 = -d ]] {
        openssl enc -aes-256-cbc -d -in $2 -out $3
    } else {
        openssl enc -aes-256-cbc -e -in $1 -out $2
    }
}

c() {
    cd $1
    ls -F --color
}

rm() {
    for i ($*) {
        [[ -e $i/.keep ]] && {
            print -P "%BDon't delete $i !!!"
            return 1
        }
    }

    =rm -v $*
}

calculate() {
    zmodload zsh/mathfunc
    echo $(($*))
}

gr() {
    grep --color $* -r .
}

k() {
    if (($# == 0)) {
        cd ..
    } else {
        go_dir='.'
        for i ({1..$1}) {
            go_dir=$go_dir/..
        }
        cd $go_dir
    }

    ls -F --color
}

t() {
    echo "$(<$1)" 2>/dev/null || ls -lF --color $* 2>/dev/null
}

cwi() {
    buffer=("${(f)$(which -a $1)}")
    print -l $buffer

    [[ -e $buffer[-1] ]] && {
        print "\n$(<$buffer[-1])"
    }
}

vwi() {
    buffer=("${(f)$(which -a $1)}")
    print -l $buffer

    [[ -e $buffer[-1] ]] && {
        vim -p $buffer[-1]
        return
    }

    buffer=$(type $1)
    buffer=${buffer#$1*function from }
    if [[ -e $buffer ]] {
        vim "+/^ *$1(" -p $buffer
    } elif [[ $buffer == *"is an alias for"* ]] {
        vim "+/^ *alias $1=" -p ~/.zshrc
    }
}

ac() {
    if (($# == 1)) {
        awk '{print $'$1'}' $2
    } elif (($# == 2)) {
        awk -F$2 '{print $'$1'}' $3
    } elif (($# == 0)) {
        awk '{print $1}' $1
    }
}

0x() {
    echo $((16#$1))
}

0o() {
    echo $((8#$1))
}

0b() {
    echo $((2#$1))
}

p16() {
    echo $(([#16] $1))
}

p8() {
    echo $(([#8] $1))
}

p2() {
    echo $(([#2] $1))
}

exaac() {
    ffmpeg -i $1 -vn -sn -c:a copy -y -map 0:a:0 $1.aac
}

tophistory() {
    num=20
    (($+1)) && num=$1
    history 1 \
        | awk '{CMD[$2]++;count++;}END \
            { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
        | column -c3 -s " " -t | sort -nr | nl | head -n$num
}

colorbar() {
    awk 'BEGIN{
        s="               "; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

loop() {
    while ((1)) {
        eval $*
    }
}

vs() {
    local args
    [[ $# -ge 1 ]] && args="zsh -ic $*"

    ssh -tq $USER@192.168.31.7 $args
}

icm() {
    git cm "$*"
}

syncdir() {
    # syncdir dir1/ dir2/
    if [[ $3 = "--run" ]] {
        rsync --delete -av $1/ $2/
    } else {
        rsync -n --delete -av $1/ $2/
    }
}

mdcd() {
    md $1
    cd $1
}

# funcend

if (($+commands[pacman])) {
    alias pac='sudo pacman --color auto'
    alias y='pacman --color auto -Ss'
    (($+commands[yaourt])) && {
        alias pac='yaourt'
        alias y='yaourt'
    }
    alias pi='pac -S'
    alias pia='pac -S --noconfirm'
    alias pli='pac -U'
    alias pud="pac -Syu"
    alias pudd="pac -Syu --aur"
    alias psu="pac -Su"
    alias pd='pac -Sw'
    alias pp='pac -Rcsn'
    alias psi='pac -Si'
    alias pq='pac -Q'
    alias pqi='pac -Qi'
    alias pqe='pacman -Qeq | sort | less'
    alias psl='pkgfile -l'
    alias pql='pac -Ql'
    alias pso='pkgfile -v'
    alias pqo='pac -Qo'
    alias pqd='pac -Qdt'
    alias pqm='pac -Qqm'
    alias prd='pac -Rdd'
    alias pae='pac -D --asexplicit'
    alias pad='pac -D --asdeps'
    alias pcl='echo y"\n"y | pac -Scc'
    alias pbs='pac -G'
    alias pfy='sudo pkgfile -uz'
    alias pls='pac -Ss'
    alias ped='sudo vim /etc/pacman.d/mirrorlist'
    alias pedd='sudo vim /etc/pacman.conf'

    pqii() {
        cat /var/lib/pacman/local/$1-*/install
    }
} elif (($+commands[apt-get])) {
    alias pg='apt-cache search'
    alias y='apt list 2>/dev/null | grep'
    alias pi='sudo apt-get install'
    alias pia='sudo apt-get install'
    alias pp='sudo apt-get purge'
    alias pud='sudo apt-get update; sudo apt-get upgrade'
    alias psu='sudo apt-get upgrade'
    alias pqd='sudo apt-get autoremove'
    alias pcl='sudo apt-get clean'
    alias pql='dpkg -L'
    alias pq='apt list --installed'
    alias pqe='apt list --installed 2>/dev/null | grep -Fv ",automatic"'
    alias pqm='apt list --installed 2>/dev/null | grep -F ",local"'
    alias psi='apt show'
    alias pqi='dpkg -s'
    alias pqo='dpkg -S'
    alias pli='dpkg -i'
    alias pls='apt list'
    alias pae='sudo apt-get install'
    alias pad='sudo apt-get markauto'
    alias pd='sudo pi -d'
    alias ped='sudo apt edit-sources'
}
#}}}

#echo $((EPOCHREALTIME - start_time))
