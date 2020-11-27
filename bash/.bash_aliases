# make rum safer
alias rm='rm -iv'

# utils
alias sz="source ~/.zshrc"
createdir ()
 {
     mkdir "$1" && cd "$1"
 }

# edit config 
alias escreds="vim ~/.es_creds && sz"
alias aliases="vim ~/.dotfiles/bash/.bash_aliases && sz"
alias dotfiles="cd ~/.dotfiles"

# git commands:
alias glog="git log --oneline --decorate --all --graph"
alias gplog="git log --pretty=format:'%h %an %s'"
alias glast="git add . && git commit --amend && git push --force-with-lease"
grbi () {
  git rebase -i "$1"
}

# tmux
alias aml="sz && tmuxinator start mohawk"

