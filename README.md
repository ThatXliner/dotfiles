# Dotfiles

> Beautiful, functional, and fast.

My dotfiles.

## Package management philosophy

- **Homebrew first** — runtimes and CLI tools go in the `Brewfile` whenever possible. Single source of truth for updates (`brew update && brew upgrade`). Reasoning can be found in `docs/decisions`
- **Language-specific tools second** — `uv tool install` for Python packages, `bun install -g` for npm packages, `cargo install` for Rust tools. Only for things not available on Homebrew.

## Installation

```sh
curl https://raw.githubusercontent.com/ThatXliner/dotfiles/master/scripts/setup | zsh
```

The setup script runs in phases:
1. **Bootstrap** — hushlogin, Xcode tools, clone repo, Homebrew, Antidote, Rust (in parallel)
2. **Tools** — Homebrew bundle, Python tools (uv), npm tools (bun), Rust tools (cargo) (in parallel)
3. **Config** — gitconfig, GPG signing, Zsh prompt, Vim plugins
4. **Shell** — links `~/.zshrc` to zshrc/index.zsh

## Contents

- `zshrc/` — My Zsh config (split into modules: `path.zsh`, `aliases.zsh`, `constants.zsh`, `completion.zsh`, etc.)
  - Source `zshrc/index.zsh` from `~/.zshrc`
  - Store API keys in `~/.zshenv`
  - Plugins managed by [Antidote](https://getantidote.github.io/) via `zshrc/zsh-plugins.txt`
- `Brewfile` — Homebrew packages (languages, CLI tools, casks)
- `config.ghostty` — Ghostty terminal configuration
- `scripts/setup` — Bootstrap a new machine
- `scripts/update_completions` — Refresh cached Zsh completions
- `nvim/` — Neovim config (AstroNvim-based)
- `docs/decisions/` — Architecture decision records (why no mise, why Podman, why Antidote, which GPG)

## Why?

1. [Everyone else is uploading their dotfiles](https://github.com/search?q=dotfiles)
2. I want to make an automation script in the future for [ThatXliner/setup](https://github.com/ThatXliner/setup)
3. My `.zshrc` was getting quite messy so I decided to make it in a folder. Then I thought, "why not organize _all_ my dotfiles as well?"
