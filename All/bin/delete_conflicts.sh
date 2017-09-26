find $HOME/Dropbox -name "*conflicted*"
read -p "Delete these? [yn]" answer
if [[ $answer = y ]] ; then
	find $HOME/Dropbox -name "*conflicted*" -delete
fi
