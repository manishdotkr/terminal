# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#custome alias
alias cvpn='sudo openvpn --config /home/manish.kumar201/vpn/cary.ovpn'
alias rvpn='sudo openvpn --config /home/manish.kumar201/vpn/rivittv.ovpn'
#python
alias python='python3'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



##################### my custom settings #####################
#ref: https://github.com/drewgrif/jag_dots/blob/main/.bashrc
# Colour codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"


############### old settings for terminal ###############
# old #PS1='\[\e[1;32m\]┌──(\u@\h)-[\w]\n└─>\[\e[0m\] '

# Function to get the current Git branch
#get_git_branch() {
#    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
#    if [ -n "$branch" ]; then
#        echo "⚙️  branch:$branch"
#    fi
#}
#PS1='\[\e[1;36m\]┌──{\u}-[\W]\[\e[1;30m\] ◀-----[\w]-----▶ {\D{ %r }}\n\[\e[1;36m\]└─> $(get_git_branch) \[\e[0m\] '
#PS1='\[\e[1;36m\]┌──{\u}-[\W]\[\e[1;30m\] ◀-----[\w]-----▶ {\D{ %r }}\n\[\e[1;36m\]└─> $(get_git_branch) \[\e[0m\] '

############### new settings for terminal ###############
get_git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        echo -e "┌── ⚙️  $branch\n└"
    else
        echo " "
    fi
}
PS1='\[\e[1;36m\]$(get_git_branch)> \[\e[0m\]'

###################### Aliases ######################
alias cc='clear'
# apt aliases
alias apt-cleanup='sudo apt autoremove -y && sudo apt clean -y'
alias apt-fix='sudo apt update -y && sudo apt --fix-broken install && sudo apt autoremove -y'
alias apt-update='sudo apt update -y'
alias apt-upgrade='sudo apt upgrade -y'
alias apt-uplist='apt list --upgradable'

alias df='df -h'
alias free='free -h'
alias myip="ip -f inet address | grep inet | grep -v 'lo$' | cut -d ' ' -f 6,13 && curl ifconfig.me && echo ' external ip'"
# Dotfiles & Files
alias bs='micro ~/.bashrc'
alias reload='source ~/.bashrc'
# change directory
alias ..='cd ..' 
alias ...='cd ../..' 
alias x="exit"
alias gd="cd ~/Downloads"
alias glth="cd ~/lth"
# Git aliases
alias gs="git status"
alias tr="tree"
# Docker Aliases
alias docker-ip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias docker-gtw="docker inspect -f '{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}'"

