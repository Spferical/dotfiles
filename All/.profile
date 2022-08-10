# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
# and the dropbox distribution folder
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$HOME/bin/thirdparty:$HOME/.dropbox-dist:$PATH:$HOME/go/bin:$HOME/.cargo/bin:/home/matthew/node_modules/.bin/"
fi

#my editor
export EDITOR="kc"
export VISUAL="$EDITOR"

# favorite terminal
export TERMINAL=alacritty
# for ranger
export TERMCMD=alacritty

# cache pip downloads
# So I don't have to redownload matplotlib ever again
export PIP_DOWNLOAD_CACHE=$HOME/.pip-download-cache

# python rc file for running when python starts
# stuff like python shell completion
export PYTHONSTARTUP="$HOME/.pyrc"

export QT_QPA_PLATFORMTHEME='gtk2'

export RUST_SRC_PATH=$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/

export FZF_CTRL_T_COMMAND="rg --hidden --files"

export MOZ_ENABLE_WAYLAND=1
