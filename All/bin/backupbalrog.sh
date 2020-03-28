backup_date=${2:-\{now\}}
echo $backup_date
borg create -v\
    --list -s\
    --compression lzma\
    -e $HOME/.cache\
    -e $HOME/.config/Riot/Cache\
    -e $HOME/.config/Electron/Cache\
    -e "$HOME/dev/*/target/rls"\
    -e "$HOME/dev/*/target/debug"\
    -e "$HOME/dev/*/target/release"\
    -e "__pycache__"\
    -e "*.pyc"\
    -e $HOME/.local/share/Steam/\
    -e $HOME/Games/\
    -e $HOME/Downloads\
    -e $HOME/.PyCharm2016.1\
    -e $HOME/.tor-browser-en\
    -e $HOME/.wine\
    -e $HOME/enc\
    -e $HOME/quote\
    -e $HOME/.rustup\
    -e $HOME/.cargo\
    "$1:/media/backup/balrog::balrog-$backup_date"\
    $HOME/
