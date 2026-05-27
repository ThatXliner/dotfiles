# My `~/.zshrc`

My Zsh configuration. Loads in ~0.08s on an M-series Mac.

## Features

- Powerlevel10k prompt
- Zoxide for smart `cd`
- zsh-autosuggestions and zsh-syntax-highlighting
- Atuin shell history sync
- Fzf-powered fuzzy completion
- Tealdeer (tldr) completion
- Thef\*ck command correction
- Colored man pages

## Completions

CLI completions are cached in `~/.config/zsh/completions`. After upgrading tools, refresh them:

```sh
~/.dotfiles/scripts/update_completions
```

## Structure

```
.
├── README.md
├── index.zsh            # Entry point — source this from ~/.zshrc
├── path.zsh             # $PATH modifications
├── constants.zsh        # Environment variables and constants
├── aliases.zsh          # Aliases and functions
├── completion.zsh       # Completion styles and settings
├── zsh-plugins.txt      # Plugin list for Antidote
├── zsh-plugins.zsh      # Static bundle (auto-generated from zsh-plugins.txt)
└── .gitignore
```
