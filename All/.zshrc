#!/usr/bin/env zsh
HISTFILE=~/.bighistfile
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
local _lvl=""
for _ in $(seq 2 "${SHLVL}"); do
    _lvl="${_lvl}*"
done
if [[ -f /run/.toolboxenv ]]; then
    _lvl="${_lvl}*"
fi
_lvl="$_yellow${_lvl}$_reset"

PROMPT="$_deco┌─[$_time$_deco|$_lvl$_name$_ssh$_deco|$_wdir$_deco|$_code$_deco]$prompt_newline$_deco└─>$ $_reset"
# keep environmental pollution down
unset _blue _bblue _deco _bcyan _bred _time _name _yellow _reset _ssh _wdir _code _lvl

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

case $TERM in
    xterm*|rxvt*|alacritty)
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

eval "$(zoxide init zsh)"

# nicer defaults
eval $(dircolors)
alias grep='grep --colour=auto'
alias pacman='pacman --color=auto'
alias less="less -R" # output color codes

alias ls='exa -F'
alias cls='clear && exa'
alias ll='exa -l'
alias lsd='exa -d */' # ls, showing only directories
alias l=exa
alias sl=exa
alias lstr='exa --sort time'
alias lh='exa -a | egrep "^\."' # ls'ing hidden files

alias pe="ps -e"
alias dh='du -ha | sort -h' # du files and sort by size
alias stats='dstat -cdnpmgs --top-bio --top-cpu --top-mem'
alias mpv="mpv --hwdec=auto"
alias t=task
alias g=git
alias tb='SHELL=/usr/bin/zsh toolbox enter tb'

function define {
	wn "$1" -over
}

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
elif [ -n "${commands[fzf-share]}" ]; then
    # nixos
    source "$(fzf-share)/key-bindings.zsh"
    source "$(fzf-share)/completion.zsh"
fi

# mem use and page fault info for time
# from burntsushi -- https://news.ycombinator.com/item?id=19525109
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S\nmaxmem\t%M MB\nfaults\t%F'

# I think gpg used to use pinentry-gnome3 on fedora, but it seems broken now.
export GPG_TTY=$(tty)

# ^G to fzf changed files in git
fzf-git-diff-widget() {
    LBUFFER="${LBUFFER}$(git diff --name-only | sort -u | awk -v prefix=\"$(git rev-parse --show-toplevel)/\" '$0=prefix$0' - | xargs realpath --relative-to="${PWD}" | fzf -m --ansi --height 40% --reverse --preview 'git diff $@ --color=always -- {-1}')"
    zle reset-prompt
}
zle -N fzf-git-diff-widget
bindkey '^G' fzf-git-diff-widget

# ^B to fzf git branches, sorted by head commit date
fzf-git-branch-widget() {
    LBUFFER="${LBUFFER}$(git for-each-ref refs/heads --format='%(refname:short)' --sort='-committerdate' | grep -o -E '\S.*\S|\S' | fzf -m --ansi --height 40% --reverse --preview 'git show ${-1} --color=always')"
    zle reset-prompt
}
zle -N fzf-git-branch-widget
bindkey '^B' fzf-git-branch-widget

# ^E to fzf files by ripgrep search
fzf-rg-widget() {
    # Based on ff from https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
    local RG_DEFAULT_COMMAND="rg --files-with-matches --hidden"
    local FZF_DEFAULT_COMMAND="rg --files" fzf
    selected=$(
        fzf \
            --multi \
            --ansi \
            --disabled \
            --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
            --height 40% \
            --reverse \
            --preview "rg --pretty --context 2 {q} {}" \
            | cut -d":" -f1,2
    )
    LBUFFER="${LBUFFER}${selected}"
    zle reset-prompt
}
zle -N fzf-rg-widget
bindkey '^E' fzf-rg-widget

fzf-zoxide-dir-widget() {
    local selected_dir
    selected_dir=$(zoxide query -l | fzf -m --ansi --height 40% --reverse --preview 'ls -A --color=always {}')
    if [ -n "$selected_dir" ]; then
        LBUFFER="${LBUFFER}${selected_dir}"
    fi
    zle reset-prompt
}
zle -N fzf-zoxide-dir-widget
bindkey '^Z' fzf-zoxide-dir-widget

alias erl='cd ~/dev/games/everythingrl && nix develop --command zsh'
