# Clean Computer Procedures

## Preparationn
* Clean home directory
* Delete programs
* Delete python packages
* Export Bitwarden
  + Encrypt Bitwarden using GPG

## Update
* pacman -Syu
* reboot
* pacman -Qett > ~/pkglist.txt
* pip list > python_pkglist.txt

## Dotfiles

Click [here](https://www.atlassian.com/git/tutorials/dotfiles) if something goes wrong.

### Starting from scratch

```bash
# Create a bare git repo to track our files
git init --bare $HOME/.dotfiles
# Create an alias to interact with the repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Set a flag to hid files we are not explicitly tracking yet
config config --local status.showUntrackedFiles no
# Add the alias definition to your .zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
Now you can version the `$HOME` directory like any other repository, just replace `git` with the `config` alias.

### Installing to a new system

```bash
# Add the alias definition to your .zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
# Apply the alias
source $HOME/.zshrc
# Ensure the source repository ignores the folder where you'll clone it to avoid recursion problems
echo ".dotfiles" >> .gitignore
# Clone the dotfiles into a bare repo
git clone --bare <git-repo-url> $HOME/.dotfiles
# Checkout the actual content from the bare repo to your $HOME
config checkout
# The above might fail because some existing files may have been overwritten by git.
# Solution: backup the files if you care about them, otherwise remove them.
# Set the flag showUntrackedFiles to no on this specific (local) repository
config config --local status.showUntrackedFiles no
```
Now you can version the `$HOME` directory like any other repository, just replace `git` with the `config` alias.

## tar (borg?)
tar -czvpf {archive-name} {~josh} {/etc}
