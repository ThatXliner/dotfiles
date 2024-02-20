# Dotfiles

> Beautiful, functional, and fast.

My dotfiles.

NOTE TO SELF: If a package is available on Homebrew and PyPi, prefer PyPi. Use pnpm for installing global stuff
## Installation

```sh
curl https://raw.githubusercontent.com/ThatXliner/dotfiles/master/scripts/setup | zsh
```

## Contents

- `zshrc`: My `~/.zshrc` (why is it a folder? The main file you need to source is actually `zshrc/index.zsh`)
- `Brewfile`: What I have installed via Homebrew
- `requirements.txt`: What I have installed via pipx
- `scripts`
  - `setup`: Install the dotfiles!

May add my Atom/VSCode/JetBrains configuration in the future.

Note to self: [Use `pnpm` for global JS installations.](https://gist.github.com/cometkim/eb2842d67b40e583e4886e9b897a6af0)

## Why?

1. [Everyone else is uploading their dotfiles](https://github.com/search?q=dotfiles)
2. I want to make an automation script in the future for [ThatXliner/setup](https://github.com/ThatXliner/setup)
3. My `.zshrc` was getting quite messy so I decided to make it in a folder. Then I thought, "why not organize _all_ my dotfiles as well?"
