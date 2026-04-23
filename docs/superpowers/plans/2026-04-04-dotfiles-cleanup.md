# Dotfiles Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Clean up the dotfiles repo: rewrite `scripts/setup` into a working, mise-centric phased script; add justification comments to `mise-config.toml`; remove dead code from `zshrc/index.zsh`.

**Architecture:** Three independent file changes — `scripts/setup` is a full rewrite organized into 4 phases (bootstrap, tools, config, shell); `mise-config.toml` gets comments and a dedup; `zshrc/index.zsh` gets two lines removed. No new files needed.

**Tech Stack:** Bash, TOML, Zsh, mise, Homebrew, antidote, rustup

---

## Files

- Modify: `scripts/setup` — full rewrite into phased structure
- Modify: `mise-config.toml` — add comments, remove duplicate `"npm:biome"`
- Modify: `zshrc/index.zsh` — remove `MISE_USE_TOML=0` and tabtab line

---

### Task 1: Rewrite `scripts/setup`

**Files:**
- Modify: `scripts/setup`

- [ ] **Step 1: Write the new `scripts/setup`**

Replace the entire file with the following:

```bash
#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------
info()    { echo "${fg[blue]}INFO: $*${fg[default]}"; }
error()   { echo "${fg[red]}ERROR: $*${fg[default]}"; }
warn()    { echo "${fg[yellow]}WARNING: $*${fg[default]}"; }
success() { echo "${fg[green]}SUCCESS: $*${fg[default]}"; }
with_color() { echo "${fg[$1]}$2${fg[default]}"; }
panic() { error "$1"; exit "${2:-1}"; }

# ---------------------------------------------------------------------------
# Phase 1 — Bootstrap
# ---------------------------------------------------------------------------
do_hushlogin() {
    if [ ! -f ~/.hushlogin ]; then
        info "1) Creating ~/.hushlogin"
        touch ~/.hushlogin
        success "1) Created ~/.hushlogin"
    else
        success "1) ~/.hushlogin already exists"
    fi
}

do_xcode_tools() {
    info "2) Installing Xcode command line tools"
    if xcode-select --install 2>/dev/null; then
        success "2) Xcode command line tools installed"
    else
        success "2) Xcode command line tools already installed"
    fi
}

clone_dotfiles() {
    info "3) Cloning dotfiles"
    if [ -d ~/dotfiles/.git ]; then
        success "3) Dotfiles already cloned"
    else
        git clone https://github.com/ThatXliner/dotfiles.git ~/dotfiles \
            || panic "3) Dotfiles failed to clone"
        success "3) Dotfiles cloned"
    fi
}

install_homebrew() {
    info "4) Installing Homebrew"
    if command -v brew &>/dev/null; then
        success "4) Homebrew already installed"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        success "4) Homebrew installed"
    fi
}

install_mise() {
    info "5) Installing mise"
    if command -v mise &>/dev/null; then
        success "5) mise already installed"
    else
        curl https://mise.run | sh
        success "5) mise installed"
    fi
}

install_antidote() {
    info "6) Installing Antidote"
    if [ -d "${ZDOTDIR:-$HOME}/.antidote" ]; then
        success "6) Antidote already installed"
    else
        git clone --depth=1 https://github.com/mattmc3/antidote.git "${ZDOTDIR:-$HOME}/.antidote" \
            || panic "6) Antidote failed to install"
        success "6) Antidote installed"
    fi
}

install_rust() {
    info "7) Installing Rust"
    if command -v rustup &>/dev/null; then
        success "7) Rust already installed"
    else
        # Rustup required before `mise install` — mise's cargo: entries need it
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        success "7) Rust installed"
    fi
}

# ---------------------------------------------------------------------------
# Phase 2 — Tools
# ---------------------------------------------------------------------------
setup_mise() {
    info "8) Setting up mise"
    eval "$(mise activate bash 2>/dev/null || ~/.local/bin/mise activate bash)"
    mkdir -p ~/.config/mise
    ln -sf ~/dotfiles/mise-config.toml ~/.config/mise/config.toml
    mise install
    success "8) mise set up"
}

brew_bundle() {
    info "9) Installing Homebrew packages"
    cd ~/dotfiles && brew bundle install
    success "9) Homebrew packages installed"
}

# ---------------------------------------------------------------------------
# Phase 3 — Config
# ---------------------------------------------------------------------------
setup_config() {
    info "10) Setting up config files"
    cp ~/dotfiles/.gitconfig ~/.gitconfig

    info "10a) GPG commit signing"
    if gum confirm "Should we sign commits with GPG?"; then
        if ! command -v gpg &>/dev/null; then
            panic "Please install GPGTools (https://gpgtools.org/) and re-run"
        fi
        git config --global commit.gpgsign true
        git config --global user.signingkey \
            "$(gum input --prompt 'Your GPG key ID: ' --placeholder 'Get it from: gpg --list-secret-keys --keyid-format=long')"
    fi

    info "10b) Setting up Zsh prompt"
    ln -sf ~/dotfiles/prompts/single.zsh ~/.p10k.zsh

    success "10) Config files set up"
}

# ---------------------------------------------------------------------------
# Phase 4 — Shell
# ---------------------------------------------------------------------------
reset_zshrc() {
    info "11) Setting up ~/.zshrc"
    echo "source $HOME/dotfiles/zshrc/index.zsh" > ~/.zshrc
    # shellcheck disable=SC1090
    source ~/.zshrc
    success "11) ~/.zshrc set up"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    setopt interactivecomments
    autoload -U colors && colors

    with_color blue '
___________.__            __ ____  ___.____    .__                   /\
\__    ___/|  |__ _____ _/  |\   \/  /|    |   |__| ____   __________)/ ______
  |    |   |  |  \\__  \\   __\     / |    |   |  |/    \_/ __ \_  __ \/  ___/
  |    |   |   Y  \/ __ \|  | /     \ |    |___|  |   |  \  ___/|  | \/\___ \
  |____|   |___|  (____  /__|/___/\  \|_______ \__|___|  /\___  >__|  /____  >
                \/     \/          \_/        \/       \/     \/           \/
'
    with_color green '
    ____          __   ____ _  __
   / __ \ ____   / /_ / __/(_)/ /___   _____
  / / / // __ \ / __// /_ / // // _ \ / ___/
 / /_/ // /_/ // /_ / __// // //  __/(__  )
/_____/ \____/ \__//_/  /_//_/ \___//____/

    ____              __          __ __
   /  _/____   _____ / /_ ____ _ / // /
   / / / __ \ / ___// __// __ `// // /
 _/ / / / / /(__  )/ /_ / /_/ // // /
/___//_/ /_//____/ \__/ \__,_//_//_/

   _____              _         __
  / ___/ _____ _____ (_)____   / /_
  \__ \/ ___// ___// // __ \ / __/
 ___/ / /__ / /   / // /_/ // /_
/____/\___//_/   /_// .___/ \__/
                   /_/
'
    with_color magenta "In a few moments, we'll set up your development environment"
    with_color magenta "This will take a while, so grab a coffee or something"
    with_color magenta "(Press Ctrl+C to cancel)"
    with_color yellow '"I hope you have as much fun using my dotfiles as I had making them!" - ThatXliner'

    # Phase 1 — Bootstrap (run parallel-safe steps in background)
    do_hushlogin
    do_xcode_tools
    clone_dotfiles
    install_homebrew &
    install_mise &
    install_antidote &
    install_rust &
    wait

    # Phase 2 — Tools
    setup_mise
    brew_bundle

    # Phase 3 — Config
    setup_config

    # Phase 4 — Shell
    reset_zshrc

    success 'All done! Enjoy your new development environment!'
}
main
```

- [ ] **Step 2: Verify the script is executable**

```bash
ls -la scripts/setup
```

Expected: file has `x` bit. If not: `chmod +x scripts/setup`

- [ ] **Step 3: Lint check (shellcheck)**

```bash
shellcheck scripts/setup
```

Expected: no errors. Fix any that appear before committing.

- [ ] **Step 4: Commit**

```bash
git add scripts/setup
git commit -m ":wrench: chore(setup): rewrite into phased mise-centric setup script"
```

---

### Task 2: Clean up `mise-config.toml`

**Files:**
- Modify: `mise-config.toml`

- [ ] **Step 1: Write the updated `mise-config.toml`**

Replace the entire `[tools]` section with the following (keep `[settings]` block unchanged at the bottom):

```toml
[tools]
# --- Languages & Runtimes ---
python = "latest"        # General-purpose scripting and tooling
bun = "latest"           # Primary JS runtime and package manager
node = "24.11.1"         # Required by some tools that don't support bun
ruby = "latest"          # Scripting and some CLI tools (e.g. jekyll)
zig = "latest"           # Systems programming experiments
java = "latest"          # Android/FRC development

# --- Package Managers & Meta-tools ---
pnpm = "latest"          # Node package manager for some projects
uv = "latest"            # Fast Python package installer and resolver
cargo-binstall = "latest" # Install pre-built Rust binaries without compiling

# --- Shell & Terminal Tools ---
bat = "latest"           # Better cat with syntax highlighting
ripgrep = "latest"       # Fast grep replacement
"cargo:eza" = "latest"   # Better ls with icons and git status
zoxide = "latest"        # Smarter cd that learns your habits
fd = "latest"            # Fast and user-friendly find replacement
fzf = "latest"           # Fuzzy finder for shell history and file search
yazi = "latest"          # Terminal file manager
zellij = "latest"        # Terminal multiplexer (tmux alternative)
mprocs = "latest"        # Run multiple commands side-by-side
delta = "latest"         # Better git diff pager
fx = "latest"            # Interactive JSON viewer
gron = "latest"          # Make JSON greppable
hyperfine = "latest"     # Command-line benchmarking tool

# --- Dev Tools ---
ruff = "latest"          # Extremely fast Python linter and formatter
"pipx:pyright" = "latest" # Python static type checker
jq = "latest"            # Command-line JSON processor
gh = "latest"            # GitHub CLI
just = "latest"          # Command runner (Makefile alternative)
atlas = "latest"         # Database schema management
prettier = "latest"      # Opinionated code formatter
biome = "latest"         # Fast JS/TS linter and formatter
pandoc = "latest"        # Universal document converter

# --- CLI Utilities ---
"aqua:atuinsh/atuin" = "latest"       # Shell history sync and search
"aqua:tealdeer-rs/tealdeer" = "latest" # Fast tldr pages client
"aqua:schollz/croc" = "latest"        # Simple file transfer between machines
"aqua:dylanaraps/neofetch" = "latest" # System info display
"npm:trash-cli" = "latest"            # Safe rm that moves to trash

# --- Language Servers & Editors ---
neovim = "latest"                     # Primary editor
"npm:@vtsls/language-server" = "latest" # VS Code language server adapter

# --- Misc / Project-specific ---
usage = "latest"            # Mise autocomplete support
"aqua:supabase/cli" = "latest" # Supabase local dev and deployments
"npm:@antfu/ni" = "latest"  # Universal package manager wrapper
"npm:sv" = "latest"         # SvelteKit project scaffolding
"npm:eas-cli" = "latest"    # Expo Application Services CLI
"npm:opencommit" = "latest" # AI-generated commit messages
"npm:@openai/codex" = "latest" # OpenAI Codex CLI
"npm:opencode-ai" = "latest" # AI coding assistant
"npm:openai-oauth" = "latest" # OpenAI OAuth helper
"npm:@gsd-build/sdk" = "latest" # GSD build SDK
"npm:taze" = "latest"       # Check and update package versions
"npm:localtunnel" = "latest" # Expose local server to the internet
"npm:@elgato/cli" = "latest" # Elgato Stream Deck plugin development
"pipx:poethepoet" = "latest" # Task runner for Python projects
"pipx:copier" = "latest"    # Project template tool
"pipx:poetry" = "2.1.1"     # Python dependency management (pinned for stability)
poetry = "latest"            # Also managed as a standalone tool
"pipx:hy" = "latest"        # Lisp-flavored Python
"pipx:ufbt" = "latest"      # Flipper Zero firmware build tool
"pipx:thefuck" = { version = "latest", uvx_args = "--python 3.11" } # Correct mistyped commands (needs 3.11)
"pipx:yt-dlp" = { version = "latest", extras = "curl-cffi" } # Download YouTube and other videos
"pipx:httpie" = "latest"    # User-friendly HTTP client
"pipx:ipython" = { version = "latest", uvx_args = " -w hid -w pyautogui -w sympy -w numpy -w pandas -w matplotlib -w requests -w aiohttp" } # Enhanced Python REPL with science libs
"pipx:open-interpreter" = "latest" # Run code via natural language
"pipx:llm" = "latest"       # CLI for querying LLMs
"pipx:scrapy" = "latest"    # Web scraping framework
"pipx:podman-compose" = "latest" # Docker Compose for Podman
aws = "latest"              # AWS CLI
"aqua:Wilfred/difftastic" = "latest" # Structural diff tool
"cargo:https://github.com/ThatXliner/rt" = "branch:main" # My personal CLI tool
# "pipx:'git+https://github.com/nari-labs/dia.git'" = { version = "latest", uvx_args = "--python 3.9" }
# "npm:wrangler" = "latest"
# "npm:vibe-kanban" = "latest"
```

- [ ] **Step 2: Verify no `"npm:biome"` duplicate remains**

```bash
grep -n 'biome' mise-config.toml
```

Expected: only one line containing `biome`, the bare `biome = "latest"` entry with its comment.

- [ ] **Step 3: Commit**

```bash
git add mise-config.toml
git commit -m ":memo: docs(mise): add justification comments and remove duplicate biome"
```

---

### Task 3: Remove dead code from `zshrc/index.zsh`

**Files:**
- Modify: `zshrc/index.zsh`

- [ ] **Step 1: Remove `MISE_USE_TOML=0`**

In `zshrc/index.zsh`, find and delete this line:

```zsh
export MISE_USE_TOML=0
```

- [ ] **Step 2: Remove the tabtab source line**

In `zshrc/index.zsh`, find and delete this line:

```zsh
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && source ~/.config/tabtab/zsh/__tabtab.zsh || true
```

- [ ] **Step 3: Verify the file looks correct**

```bash
cat -n zshrc/index.zsh
```

Confirm neither `MISE_USE_TOML` nor `tabtab` appears in the output.

- [ ] **Step 4: Commit**

```bash
git add zshrc/index.zsh
git commit -m ":fire: chore(zshrc): remove stale MISE_USE_TOML and tabtab lines"
```
