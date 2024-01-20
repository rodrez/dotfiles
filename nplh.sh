echo "Cloninig bare repo"
git clone --bare git@github.com:rodrez/dotfiles.git $HOME/.dotfiles

function config {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ $@
}

echo "Creating config backup dir"
mkdir -p .config-backup

echo "Initial checkout"
config checkout
if [ $? = 0]; then
    echo "Config checked out"
else 
    echo "Backing up previous config"
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I {} mv .config-backup/{}
fi;

echo "Final checkout"
config checkout 

echo "Hiding untrack files from config(git)"
config config status.showUntrackedFiles no
