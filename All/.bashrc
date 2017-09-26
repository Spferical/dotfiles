#if not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f "$HOME/.bash_color" ]; then
 . "$HOME/.bash_color"
fi

if [ -f "$HOME/.bash_ps1" ]; then
 . "$HOME/.bash_ps1"
fi

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

#i want a large bash history
export HISTSIZE=1000000000000000000
# I don't want my bash history to be wiped whenever I accidentally my config.
HISTFILE=~/.history
#ignore duplicates in bash history
HISTCONTROL=ignoredups
#append to bash history instead of loading it every new terminal
shopt -s histappend
PROMPT_COMMAND=$PROMPT_COMMAND'; history -a'

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

#cool colors for manpages
#alias man="TERMINFO=~/.terminfo TERM=mostlike LESS=C PAGER=less man"
#ls, showing only directories
alias lsd='ls -d */'

#for utilizing all 4 cores on my netbook for playing videos
#due to the lack of linux drivers for the GMA3600
alias quadplayer="mplayer -lavdopts threads=4"

netls() {
    awk '/:/ { sub(":", "", $1); print $1 }' /proc/net/dev
}

# Display image with tput
function image() {
    convert "$1" -resize 40 txt:-|sed -E 's/://;s/\( ? ?//;s/, ? ?/,/g;s/\)//;s/([0-9]+,[0-9]+,[0-9]+),[0-9]+/\1/g;s/255/254/g;/mage/d'|awk '{print $1,$2}'|sed -E 's/^0,[0-9]+ /print "echo;tput setaf "\;/;s/^[0-9]+,[0-9]+ /print "tput setaf ";/;s/(.+),(.+),(.+)/\1\/42.5*36+\2\/42.5*6+\3\/42.5+16/'|bc|sed 's/$/;echo -n "  ";/'|tr '\n' ' '|sed 's/^/tput rev;/;s/; /;/g;s/$/tput sgr0;echo/'|bash
}

# as of 3/23/2014, I've mispelled yaourt as "yoaurt" for the 15th time.
alias y=yaourt
alias ys="yaourt -S"
alias yss="yaourt -Ss"

function download_website() {
	#usage: download_website url
	wget --mirror -p --convert-links -P "$1""files" "$1"
}

alias gzim="gvim ~/Dropbox/Notebooks/Notes/"
alias pe="ps -e"
alias tmuxa='~/bin/tmx alpha'
alias t=task
alias l=ls
alias lstr='ls --sort time --reverse'

# quickly share a folder
alias share='ip addr | grep inet; python3 -m http.server'

# ls'ing hidden files
alias lh='ls -a | egrep "^\."'

# du files and sort by size
alias dh='du -ha | sort -h'

alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'

alias pianobar='aoss pianobar'

# to be funny, copied from the actual suicide-linux .deb
# (shows up when you actually do install suicide-linux)
echo " ========================================================="
echo " WARNING: Suicide-Linux installed"
echo "          (http://sourceforge.net/projects/suicide-linux/)"
echo " ========================================================="


dot () {
	for ((i = 0; i < $1; i++)); do echo -n "."; sleep 0.04; done; echo -e '[\033[00;32mCOMPLETE\033[00;0m]';sleep 0.6
}

alias ls='find . -name "*" -type f -exec echo "removed {}" \;'
