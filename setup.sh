# !/bin/bash

# dev installs
# firefox, iterm2, spotify, postman, whatsapp, slack
# pgAdmin4, pycharm, emacs, xcode, whatsapp, android studio
# vs code, 

# music installs
# splice, logic pro x, metronome x

# run after cloning for the first time
cd ~ 
# mv dot-files ~/.dotfiles
# mkdir .config/tmuxinator
# cd ~

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew update
brew install cask
brew cask install iterm2
brew cask install firefox
brew cask install spotify
brew install htop
brew install httpie

# tmux and tmuxinator
brew install tmux
brew install tmuxinator

# oh my zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# pyenv
curl https://pyenv.run | bash

# heroku
brew tap heroku/brew && brew install heroku
heroku autocomplete
printf "$(heroku autocomplete:script zsh)" >> ~/.zshrc; source ~/.zshrc

# postgres
brew install postgresql@12


# symbolic links

ln ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s  ~/.dotfiles/.tmuxinator/ ~/.config/tmuxinator
ln ~/.dotfiles/.zsh/.zshenv ~/.zshenv
ln ~/.dotfiles/.zsh/.zshrc ~/.zshrc
ln ~/.dotfiles/vim/.vimrc ~/.vimrc
