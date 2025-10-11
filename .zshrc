autoload -U colors && colors
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

export PATH=$PATH:"$HOME/.local/bin"

alias vim='nvim'
alias la='ls -la --color=always'
alias ta='tmux attach'

# Bind ESC+s to run tmux-sessionizer
bindkey -s '^[s' 'tmux-sessionizer\n'

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
