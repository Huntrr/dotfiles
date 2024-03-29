# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
ZSH_THEME="arrow"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git macos brew vi-mode web-search zsh-autosuggestions autojump history-substring-search)

# User configuration
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ALIASES
alias balias='vim ~/.zshrc && source ~/.zshrc'
alias vim=nvim

# git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"

source ~/.private_zshrc
