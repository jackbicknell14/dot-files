export EDITOR="vim"

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# PyEnv Config

export PATH="$HOME/.pyenv/bin:$PATH"
export PATH=$PATH:/usr/local/sbin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "$HOME/.es_creds"
source "$HOME/.keys"
source "$HOME/.ourfm_creds"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

alias tmuxpy="tmuxinator start python"
alias amm="tmuxinator start moneymachine"
alias aml="tmuxinator start mohawk"
eval "$(pyenv init -)"

alias escreds="sudo vim ~/.es_creds"
alias fixup="git add . && git commit --fixup HEAD && git rebase -i master --autosquash && git push --force-with-lease"
alias gap="git add . && git commit -m 'updated materials' && git push && git push heroku master"
createdir ()
{
    mkdir "$1" && cd "$1"
}

# added by Anaconda3 2019.10 installer

# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
