#!/usr/bin/env bash

dirs=("All" $(hostname))

case "$1" in
	"remove" )
		for dir in "${dirs[@]}"; do
			#removes all symlinks to here from ~ owned by stow
			stow -D -v 1 -t ~ "$dir"
		done
		;;
	"setup" )

		# sets up symlinks to all dotfiles
		# easy solution: remove all symlinks, then create all symlinks

		for dir in "${dirs[@]}"; do
			# removes all symlinks that exist already from stow
			stow -D -v 1 -t ~ "$dir"
			# link all dotfiles to here
			# verbosity=1: tells you what it's linking/removing
			stow -v 1 -t ~ "$dir" --override="*"
		done

		# make a swap folder for vim if it doesn't already exist
		mkdir -p ~/.vimswap
		;;
	* )
		echo "dotfiles.sh remove -- remove symlinks"
		echo "dotfiles.sh setup -- sets up symlinks"
		;;
esac
