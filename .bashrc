source $HOME/.myshrc

[ -n "$MYSSH" ] && {
    export TERM="xterm"
    shopt -s expand_aliases
}

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
