#
#   .zsh configuration file for Linux PC#	
#

export HOST=`hostname`
export OS=LINUX
export PATH=.:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/sbin:/sbin:/home/dazai/bin
export LD_LIBRARY_PATH=/lib:/usr/local/lib:${LD_LIBRARY_PATH}
export MANPATH=/usr/local/share/man:/usr/share/man
export LANG=ja_JP.UTF-8
export TERM='xterm-256color'

export XMODIFIERS=@im=SCIM

export USER=`whoami`
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESSCHARSET=utf-8
export PRINTER=sadaie
export DOMAINNAME=sc.ctrl.titech.ac.jp
export TMPDIR=/tmp
export MATX_HISTFILE=~/.matx_history	# for matx
export MATX_HISTSIZE=20		# for matx

if [ $TERM != dumb && $TERM != linux && $?SSH_CLIENT == 0 ]; then
	export DISPLAY=`who am i | sed -n -e 's/.*(\([^:.]*\)[:]*.*).*/\1:0.0/p'`
	if [$DISPLAY == '' && $TERM == linux]; then
		export DISPLAY=''
	fi
fi

umask 022

## Default shell configuration
#
# set prompt
#
autoload colors
colors

PROMPT="%{${fg[red]}%}[%n@%m] (%T) %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[red]}%}[%~]%{${reset_color}%}"

# noautoremoveslash beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes to end of it)
bindkey -e

## Command history configuration
#
HISTSIZE=30
SAVEHIST=30

#   Common Aliases
#
alias ls="ls --color"
alias la="ls -a"
alias ll="ls -alh"
alias lf="ls -F"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias x="exit"
alias h="history"
alias df="df -h"
alias du="du -h"
alias less="less -r"
alias open="xdg-open"
alias relogin="exec $SHELL -l"
alias emacs="env XMODIFIERS=@im=none emacs"
alias deck='firefox https://tweetdeck.twitter.com/'
alias lm="latexmk -pvc -halt-on-error"
cdls(){
	\cd "$@" && ls
}
alias cd="cdls"
zstyle ':completion:*:default' menu select=2
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
%# "

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end
setopt correct
clear
