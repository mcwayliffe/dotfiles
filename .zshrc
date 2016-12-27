ZSH_THEME="miloshadzic"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)

export EDITOR='vim'
export ZSH=$HOME/.oh-my-zsh

# User configuration (machine-specific) goes in .zsh_profile
source  $HOME/.zsh_profile

source $ZSH/oh-my-zsh.sh
# Fix the HEAD^ git bug
unsetopt NO_MATCH


