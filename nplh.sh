git clone --bare git@github.com:rodrez/dotfiles.git $HOME/.dotfiles

function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ $@
}

mkdir -p .config-backup
config checkout
if [ $? = 0]; then
    echo "Config checked out"
else 
    echo "Backing up previous config"
    config checkout 2>&1 | egreg "\s+\." | awk {'print $1'} | xargs - I {} mv .config-backup/{}
fi;

config checkout 
config config status.showUntrackedFiles no
