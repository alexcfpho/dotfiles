# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
# quiet: on a freshly set-up machine, compinit's insecure-directories check
# (fresh Homebrew/oh-my-zsh completion dirs often have different perms than
# the origin machine) prints to console and trips instant prompt's warning.
# compinit -u below skips that check; this is a belt-and-suspenders silence.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    autojump
    zsh-autosuggestions
    zsh-syntax-highlighting
    kubectl-autocomplete
    gradle-completion
    fzf
)


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

alias k=kubectl
#alias compdef k=kubectl
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'

jdk() {
    version=$1
    export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
    java -version
}


autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -u
eval "$(zoxide init --cmd cd zsh)"
fpath=(~/.oh-my-zsh/custom/plugins $fpath)
source $ZSH/oh-my-zsh.sh

export HOMEBREW_NO_ANALYTICS=1

alias tg="terragrunt"
alias tf="terraform"
alias python="python3"
