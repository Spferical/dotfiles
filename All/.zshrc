HISTFILE=~/.histfile
HISTSIZE=100000000000000
SAVEHIST=100000000000000000
setopt appendhistory autocd extendedglob nomatch notify extendedhistory
setopt histignorespace
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
local _code="%(?..%{$_bred%})%?"

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
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # fedora
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    # archlinux
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

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
alias cls='clear && exa'

# common ls alias
alias ll='exa -l'

#ls, showing only directories
alias lsd='exa -d */'

alias pe="ps -e"
alias l=exa
alias lstr='exa --sort time'

# ls'ing hidden files
alias lh='exa -a | egrep "^\."'

# du files and sort by size
alias dh='du -ha | sort -h'

alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'

alias eclim=/usr/lib/eclipse/eclim
alias eclimd=/usr/lib/eclipse/eclimd

alias mpv="mpv --hwdec=auto --vo=opengl"

alias t=task

alias sl=exa

# edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# fzf
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    # archlinux
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
elif [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
    # fedora
    source /usr/share/fzf/shell/key-bindings.zsh
fi

# mem use and page fault info for time
# from burntsushi -- https://news.ycombinator.com/item?id=19525109
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S\nmaxmem\t%M MB\nfaults\t%F'
