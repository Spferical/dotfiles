HISTFILE=~/.histfile
HISTSIZE=10000000000000
SAVEHIST=100000000000000000
setopt appendhistory autocd extendedglob nomatch notify extendedhistory
# vikeys
bindkey -v

# make sure .profile things are set
source ~/.profile

zstyle :compinstall filename '/home/matthew/.zshrc'

autoload -Uz compinit
compinit

# prompt
autoload -U promptinit
promptinit
autoload -U colors && colors
local _blue="%{$fg_no_bold[blue]%}"
local _bblue="%{$fg_bold[blue]%}"
local _deco="%{$fg_no_bold[white]%}"
local _bcyan="%{$fg_bold[cyan]%}"
local _bred="%{$fg_bold[red]%}"
local _time="$_blue%*"
local _name="$_bcyan%n"
local _yellow="%{$fg_no_bold[yellow]%}"
local _reset="%{$reset_color%}"
# only show hostname info if we are sshing
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
	local _ssh="$_reset@$_yellow%M"
else
	local _ssh=""
fi
local _wdir="$_bblue%~"
local _code="$_bred%?"
PROMPT="$_deco┌─[$_time$_deco|$_name$_ssh$_deco|$_wdir$_deco|$_code$_deco]$prompt_newline$_deco└─>$ $_reset"
# keep environmental pollution down
unset _blue _bblue _deco _bcyan _bred _time _name _yellow _reset _ssh _wdir _code

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

# completion of command line switches for aliases
setopt completealiases

# ignore duplicate lines in history
setopt HIST_IGNORE_DUPS

# don't send SIGHUP to background processes when the shell exits
setopt nohup

# syntax higlighting like fish
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ctrl+r history search
bindkey '^R' history-incremental-search-backward

case $TERM in
    xterm*|rxvt*)
    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;zsh %n@%m: %~\a"
    }
    # Write command and args to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;%s\a" "$1"
    }
  ;;
esac

# z
. ~/bin/thirdparty/z.sh

# nicer defaults
eval $(dircolors)
alias ls='ls -F --color=auto'
alias grep='grep --colour=auto'
alias pacman='pacman --color=auto'
alias less="less -R" # output color codes

alias namemaker="shuf -n 2 /usr/share/dict/words | tr -dc 'A-Za-z0-9'"
function define {
	wn "$1" -over
}
alias cls='clear && ls'
alias wat='echo wat is it'

# common ls alias
alias ll='ls -l'

function hack {
    ip
    ping -c 3 localhost
    traceroute google.com
    hexdump -C /dev/urandom
}

#ls, showing only directories
alias lsd='ls -d */'

#for utilizing all 4 cores on my netbook for playing videos
#due to the lack of linux drivers for the GMA3600
alias quadplayer="mplayer -lavdopts threads=4"

# list network devices
netls() {
    awk '/:/ { sub(":", "", $1); print $1 }' /proc/net/dev
}

# Display image with tput
function image() {
    convert "$1" -resize 40 txt:-|sed -E 's/://;s/\( ? ?//;s/, ? ?/,/g;s/\)//;s/([0-9]+,[0-9]+,[0-9]+),[0-9]+/\1/g;s/255/254/g;/mage/d'|awk '{print $1,$2}'|sed -E 's/^0,[0-9]+ /print "echo;tput setaf "\;/;s/^[0-9]+,[0-9]+ /print "tput setaf ";/;s/(.+),(.+),(.+)/\1\/42.5*36+\2\/42.5*6+\3\/42.5+16/'|bc|sed 's/$/;echo -n "  ";/'|tr '\n' ' '|sed 's/^/tput rev;/;s/; /;/g;s/$/tput sgr0;echo/'|bash
}

alias p=pacaur
alias pss="pacaur -Ss"

function download_website() {
	#usage: download_website url
	wget --mirror -p --convert-links -P "$1""files" "$1"
}

alias gzim="gvim ~/Dropbox/Notebooks/Notes/"
alias pe="ps -e"
alias tmuxa='tmx alpha'
alias l=ls
alias lstr='ls --sort time --reverse'

# quickly share a folder
alias share='ip addr | grep inet; python3 -m http.server'

# ls'ing hidden files
alias lh='ls -a | egrep "^\."'

# du files and sort by size
alias dh='du -ha | sort -h'

alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'

alias eclim=/usr/lib/eclipse/eclim
alias eclimd=/usr/lib/eclipse/eclimd

alias mpv="mpv --hwdec=auto --vo=opengl"

alias t=task

# to be funny, copied from the actual suicide-linux .deb
# (shows up when you actually do install suicide-linux)
echo " ========================================================="
echo " WARNING: Suicide-Linux installed"
echo "          (http://sourceforge.net/projects/suicide-linux/)"
echo " ========================================================="


dot () {
	for ((i = 0; i < $1; i++)); do echo -n "."; sleep 0.04; done; echo -e '[\033[00;32mCOMPLETE\033[00;0m]';sleep 0.6
}

# edit command in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
