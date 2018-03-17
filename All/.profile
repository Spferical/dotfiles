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
    PATH="$HOME/bin:$HOME/bin/thirdparty:$HOME/.dropbox-dist:$PATH:$HOME/go/bin"
fi

#my editor
export EDITOR="nvim"
export VISUAL="$EDITOR"

# favorite terminal
export TERMINAL=xfce4-terminal
# for ranger
export TERMCMD=xfce4-terminal

# darwinia/multiwinia use this, and default to oss
# which makes the sound in the menus weird
# so tell it to use alsa
export SDL_AUDIODRIVER=alsa

# cache pip downloads
# So I don't have to redownload matplotlib ever again
export PIP_DOWNLOAD_CACHE=$HOME/.pip-download-cache

# python rc file for running when python starts
# stuff like python shell completion
export PYTHONSTARTUP="$HOME/.pyrc"

#always truncate ponysay height, even when not in TTY
export PONYSAY_TRUNCATE_HEIGHT=1

export BUILDDIR=/var/tmp/pacaurtmp-$USER

export QT_QPA_PLATFORMTHEME='gtk2'

export RUST_SRC_PATH=$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/
