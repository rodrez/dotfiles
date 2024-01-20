# Managed dotfiles


## Initializing the bare repo
```bash
# Creates the bare repo, used to track the files
git init --bare $HOME/.dotfiles

# We create an alias `config` which will be used instead 
# of git when we want to intearct with the configs repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# We hide the file that we are not explicitly tracking
# So when we use git status we only see what we added explicitly
config config --local status.showUntrackedFiles no

# Adds the alias to your shell rc for future use
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

## Replicating in new home

First we need to make sure we have the alias in 
your shell of preference. 

```bash
# Adds the alias to your shell rc for future use
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc

# We now need the source repo to ignore the folder
echo ".dotfiles" >> .gitignore

# Clone the files in a bare repo in the .dotfiles folder
# on your $HOME
git clone --bare git@github.com:rodrez/dotfiles.git $HOME/.dotfiles

# Checkout the actual content of the repo to your $HOME
config checkout

# NOTE: The above most likely will cause conflicts
# due to stock config files

# To avoid that you can simply backup your files, or 
# delete them completely

# You could do something like the below to move all 
# offending files to a backup dir
mkdir -p .config-backup && config checkout 2>&1 |egrep"ls+\." | awk {'print $1'} |  \
xargs -I {} mv {} .config-backup/{}


# We would run checkout again
config checkout 

# Don't forget to set showUntrackedFiles to no
config config --local status.showUntrackedFiles no
```


