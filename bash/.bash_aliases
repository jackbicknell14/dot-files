# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"

# Bash
alias ls="ls -a"
mkdir () { mkdir "$1" && cd "$1"}

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# make rum safer
alias rm='rm -iv'

# utils
alias sz="source ~/.zshrc"

# edit config 
alias escreds="vim ~/.es_creds && sz"
alias aliases="vim ~/.dotfiles/bash/.bash_aliases && sz"
alias dotfiles="cd ~/.dotfiles"

# git commands:
alias glog="git log --oneline --decorate --all --graph"
alias gplog="git log --pretty=format:'%h %an %s'"
alias glast="git add . && git commit --amend && git push --force-with-lease"
alias g="git status"
alias gb="git branch -a"
alias gp="git push"
alias gpf="git push --force-with-lease"

gco () {git checkout "$1" & git pull}
gr () {git rebase -i "$1"}

# tmux
alias aml="sz && tmuxinator start mohawk"
alias tmuxpy="tmuxinator start python"
alias amm="tmuxinator start moneymachine"
