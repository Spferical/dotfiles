borg create -v --list -s --compression lzma -e $HOME/.cache -e "__pycache__" -e "*.pyc" -e $HOME/.local/share/Steam/ -e $HOME/enc "file:///media/backup/home::home-{now}" $HOME/ 
