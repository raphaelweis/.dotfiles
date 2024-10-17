export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

bindkey -s "^[s" "tmux-sessionizer\n"
alias vim='nvim'
alias ta='tmux attach'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

if [ -e /home/raphaelw/.nix-profile/etc/profile.d/nix.sh ]; then . /home/raphaelw/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/raphaelw/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
