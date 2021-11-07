# Run cached prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Activate the primitive requisites
source "${0:h}/constants.zsh"
source "${0:h}/path.zsh"
# Activate the juicy stuff
source "${0:h}/omz.zsh"
source "${0:h}/aliases.zsh"

rm -rf $HOME/temp
rm -rf $HOME/.pylint.d

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias _

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
