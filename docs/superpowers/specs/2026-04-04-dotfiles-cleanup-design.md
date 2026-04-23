# Dotfiles Cleanup & Setup Script Update

**Date:** 2026-04-04  
**Scope:** `scripts/setup`, `mise-config.toml`, `zshrc/index.zsh`

## Goals

1. Make `scripts/setup` actually work end-to-end on a fresh Mac
2. Make `scripts/setup` mise-centric — remove special cases for rust, pipx, antidote (let mise handle everything)
3. Add justification comments to every tool in `mise-config.toml`
4. Remove obvious dead code from `zshrc/index.zsh`

## `scripts/setup` — Phased Rewrite

Reorganize into 4 phases, all functions, called sequentially from `main`.

### Phase 1 — Bootstrap (parallel-safe steps)

- `hushlogin` — create `~/.hushlogin` if missing
- `xcode_tools` — run `xcode-select --install`
- `clone_dotfiles` — idempotent: if `~/dotfiles` exists and is a git repo, skip; otherwise clone from GitHub
- `install_homebrew` — idempotent: check `brew` exists, install if not
- `install_mise` — idempotent: check `mise` exists, install via `curl https://mise.run | sh` if not
- `install_antidote` — idempotent: check `~/.antidote` exists, clone if not

### Phase 2 — Tools (depends on Phase 1)

- `setup_mise` — symlink `~/dotfiles/mise-config.toml` to `~/.config/mise/config.toml`, then run `mise install`
- `brew_bundle` — run `brew bundle install` from `~/dotfiles` (currently commented out — fix this)

`do_pipx` is **removed** — mise handles pipx tools via `pipx:*` entries.

`install_rust` is **kept but simplified** — mise's `cargo:*` entries require rustup to already be present, so rust must be installed before `mise install`. Simplify to a single idempotent check: if `rustup` is already installed, skip; otherwise run the rustup installer. Move it into Phase 1 alongside mise/antidote.

### Phase 3 — Config

- `setup_config` — copy `.gitconfig`, interactive GPG signing prompt, symlink `prompts/single.zsh` to `~/.p10k.zsh`
- Remove vim-plug install — nvim uses lazy.nvim; `.vimrc` reference is stale

### Phase 4 — Shell

- `reset_zshrc` — write `source ~/dotfiles/zshrc/index.zsh` to `~/.zshrc`, then source it

### Clone Idempotency (Option C)

```bash
clone_dotfiles() {
    if [ -d ~/dotfiles/.git ]; then
        success "3) Dotfiles already cloned"
    else
        git clone https://github.com/ThatXliner/dotfiles.git ~/dotfiles || panic "3) Dotfiles failed to clone"
        success "3) Dotfiles cloned"
    fi
}
```

### Step Numbering

Renumber all steps cleanly 1–N to match the new phase order. Remove gaps left by deleted functions.

## `mise-config.toml` — Justification Comments + Dedup

### Remove duplicate

`"npm:biome"` and `biome` (bare) both exist. Remove `"npm:biome"`, keep `biome`.

### Add comments

Group tools into sections with one-line justification comments:

- **Languages/runtimes:** `python`, `bun`, `node`, `ruby`, `zig`, `java`
- **Package managers / meta-tools:** `pnpm`, `uv`, `cargo-binstall`
- **Shell/terminal tools:** `bat`, `ripgrep`, `eza`, `zoxide`, `fd`, `fzf`, `yazi`, `zellij`, `mprocs`, `delta`, `fx`, `gron`, `hyperfine`
- **Dev tools:** `ruff`, `pyright`, `jq`, `gh`, `just`, `atlas`, `prettier`, `biome`, `pandoc`
- **CLI utilities:** `atuin`, `tldr` (tealdeer), `croc`, `neofetch`, `trash-cli`
- **Language servers / editors:** `neovim`, `vtsls`
- **Project-specific / misc:** `usage`, `supabase`, `ni`, `sv`, `eas-cli`, `opencommit`, `codex`, `llm`, `yt-dlp`, `httpie`, `ipython`, `scrapy`, `poetry`, `copier`, `poe`, `hy`, `ufbt`, `thefuck`, `open-interpreter`, `aws`, `podman-compose`, `localtunnel`, `elgato-cli`

Commented-out tools (`dia`, `wrangler`, `vibe-kanban`) remain unchanged — intentional placeholders.

## `zshrc/index.zsh` — Dead Code Removal

### Remove `MISE_USE_TOML=0`

This disables TOML config format, but `mise-config.toml` IS TOML — a direct contradiction. Remove it.

### Remove tabtab source line

```zsh
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && source ~/.config/tabtab/zsh/__tabtab.zsh || true
```

This is a stale pnpm/npm completion artifact not actively managed in this repo.

Everything else (p10k, iterm2 integration, plugin loading) stays as-is.
