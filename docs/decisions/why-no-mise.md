# Why no mise (or Nix)

## Why not mise?

Too many tools ship their own auto-updaters that expect a "normal" setup — tools installed in standard locations like `/opt/homebrew/bin/` or `~/.cargo/bin/`. Mise installs everything into its own `~/.local/share/mise/` shim layer, which confuses auto-updaters. They can't find themselves, fail to update, or worse, install a second copy alongside the mise-managed one. This creates a maintenance nightmare where neither the user nor the tool knows which version is "real."

## Why not Nix / NixOS?

Nix does not work well on macOS, especially for compiling from source. Many packages assume Linux FHS conventions, and Darwin-specific build failures are common. The darwin fork (nixpkgs) lags behind and requires manual override for simple things. On a Mac, the cost-to-benefit ratio of Nix is not worth it — Homebrew covers package management with far fewer sharp edges.

## Why prefer Homebrew over language-specific package managers (uv, bun, cargo)?

Version management hell regarding the language runtime itself otherwise. When you let uv manage Python, bun manage Node, and cargo manage Rust tooling, you end up with three separate version-management systems that don't talk to each other and have inconsistent update cadences. Homebrew provides a single source of truth for all CLI tools and runtimes — `brew update && brew upgrade` catches everything. Language-specific tools (uv, bun, cargo) are still used for language-level dependencies and tools not available on Homebrew, but the runtime and primary CLI tools come from Homebrew.
