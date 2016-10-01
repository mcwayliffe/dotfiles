ZSH_THEME="miloshadzic"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)

source $ZSH/oh-my-zsh.sh
# User configuration (machine-specific) goes in .zsh_profile
source  $HOME/.zsh_profile

export EDITOR='vim'
