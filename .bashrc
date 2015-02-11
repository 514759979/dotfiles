[ $0 = '-bash' ] && exec zsh

source $HOME/.myshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
