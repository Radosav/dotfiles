#
# ~/.bashrc
#

xmodmap ~/.Xmodmap

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ $TERM != "screen" ]] && exec tmux -2

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

