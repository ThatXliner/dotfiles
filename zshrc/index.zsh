# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# See https://github.com/mattmc3/antidote/issues/24
# (or else the asdf plugin won't work)
autoload -Uz compinit && compinit


export ZDOTDIR="${0:h}"
source $HOME/.antidote/antidote.zsh
# $PATH modifications
export PATH="$HOME/homebrew/bin:$PATH"
# Constant configuration
export EDITOR="/usr/bin/vim"
export PAGER="less -r"
# Plugin configuration
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Load plugins
antidote load
# Aliases
source $ZDOTDIR/aliases.zsh
# Miscellaneous
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Run cached prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# # Activate the primitive requisites
# source "$__DOTFILES_ZSH_DIR/constants.zsh"  # Very critical stuff
# source "$__DOTFILES_ZSH_DIR/path.zsh"  # Compiler flags, $PATH, etc
# # Activate the juicy stuff
# source "$__DOTFILES_ZSH_DIR/omz.zsh"  # Oh-my-zsh configuration
# source "$__DOTFILES_ZSH_DIR/aliases.zsh"  # My aliases and functions and chwpd hook lol

# # Add nnn stuff
# source "$__DOTFILES_ZSH_DIR/nnn-config.zsh"

# # rm -rf $HOME/temp  # TODO: Make cron tab
# rm -rf $HOME/.pylint.d

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# unalias _

# export PATH="$(echo $HOME/.nvm/versions/node/*$(cat ~/.nvm/alias/default)*/bin):$PATH"
# alias rm="trash"

# # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
