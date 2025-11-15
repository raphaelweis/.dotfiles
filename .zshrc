export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"$HOME/.codeium/windsurf/bin"
export PATH=$PATH:"$HOME/.local/share/nvim/mason/bin"
export PATH=$PATH:"$HOME/bin"

alias vim='nvim'
alias la='ls -la --color=always'
alias ta='tmux attach'

# Bind ESC+s to run tmux-sessionizer
bindkey -s '^[s' 'tmux-sessionizer\n'

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

