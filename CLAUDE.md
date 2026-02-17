# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

**Target:** macOS · ZSH · Neovim · Kitty · JetBrains

Modular dotfiles using XDG Base Directory spec. Plugin-based ZSH architecture with extensive git workflow automation.

## Setup

```bash
make install    # Bootstrap dependencies
make mac        # macOS-specific setup
make update     # git pull + relink all
```

**File structure:**
- `etc/%` → `~/.%` (home dotfiles)
- `config/%` → `~/.config/%` (XDG configs)
- `bin/%` → `~/bin/%` (scripts)

## Key Architecture

### ZSH Plugin System

Modular plugin loading from `config/zsh/plugins/`. Each plugin has an init file:
- `python` - Auto-activates venv, `mkvenv`, `uvs` aliases
- `fzf` - Fuzzy finder integration
- `kubectl`, `docker` - Completions

Config: `~/.zshrc` (customize freely, copied from template)

**Customization:**
```bash
export ZSH_THEME="default"
export ZSH_MODE="vi"
export ZSH_VI_ESC="jk"
export GIT_AUTO_FETCH=1
```

### Git Auto-Fetch

Automatic `git fetch` every 24h before computing prompt (commits ahead/behind).

- Global: `export GIT_AUTO_FETCH=1`
- Per-repo disable: `touch .git/no-auto-fetch`
- Implementation: `config/zsh/lib/libgit.sh`

### Git Hooks

**post-checkout & post-merge:** Run `git-update-deps` script
- Disable: `touch .git/.no-git-update-deps`
- Location: `config/git/hooks/`

### Conventional Commits

Use git aliases for consistency:
```bash
git feat "message"      # feat: message
git fix "message"       # fix: message
git chore "message"     # chore: message
```

All aliases in `config/git/config` (organized by section: assume, logs, branches, commit, sync, merging)

### Merge/Diff Strategy

- Default branch: Fast-forward only (`pull.ff = only`)
- Diff tool: Kitty `kitten diff` (default), IntelliJ as fallback
- Merge tool: IntelliJ IDEA, Neovim

## Essential Commands

### Git Workflow

**Aliases:**
```bash
# Common
gs, ga, gaa, gc, gco, gd, gp, gpu, gl

# Branch management
git default             # Detect main branch
git cleanup             # Delete merged branches
git fuzzy-checkout      # fzf branch selector
brt                     # git branch-time

# Syncing
git up                  # Pull with rebase
git sync                # Custom sync (bin/git-sync)

# Logs
git l                   # Graph log
git cl [base] [head]    # Commits between branches

# Advanced
git assume <file>       # Assume unchanged
git fassume             # fzf assume selector
git amend               # Amend without edit
git wipe                # Savepoint + hard reset
git pytype              # Type check changed .py files
```

### ZSH

**Global aliases:**
```bash
command NUL    # >/dev/null 2>&1
command C      # | pbcopy
command JQ     # | jq
```

**Navigation:**
```bash
cdc            # cd ~/.config
cdd            # cd ~/Desktop
```

**Python:**
```bash
venv           # Activate .venv or venv
mkvenv         # Create venv
uvs            # uv sync
```

## Configuration Locations

**XDG compliance:**
- Configs: `~/.config/zsh/`, `~/.config/git/config`, `~/.config/kitty/kitty.conf`
- Cache: `~/.cache/zsh_history`
- Data: `~/.local/share/tmux/plugins`

**Local overrides:**
- Git: `.gitconfig.local` (user, email, signing)
- ZSH: `~/.zshrc` (copied from template)
- Claude: `.claude/settings.local.json` (gitignored)

**Editors:**
- Neovim: Separate repo [robhurring/dotvim](https://github.com/robhurring/dotvim)
- IdeaVim: `config/ideavim/ideavimrc`
- Cursor/VSCode: `config/cursor/User/`

**Cursor/VSCode Extensions:**
- [Vim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)

Note: Multi-key bindings must be defined in `vim.normalModeKeyBindingsNonRecursive` (settings.json), not keybindings.json. Cursor's chord system intercepts keys before vim can process them, breaking operators like `gr` (replaceWithRegister) and `gc` (commentary).

## Notable Scripts (bin/)

- `git-sync` - Advanced sync workflow
- `git-cleanup` - Remove merged/squash-merged branches
- `git-update-deps` - Post-checkout/merge dependency updates
- `git-fuzzy-checkout` - fzf branch selection
- `fasd` - Fast directory jumping
- `today` - Todoist integration

## Making Changes

Git aliases: Edit `config/git/config` (organized by comment sections)

ZSH plugins:
1. Create `config/zsh/plugins/<name>/<name>.zsh`
2. Add `load_plugin <name>` to `config/zsh/zshrc`

Changes to symlinked files take effect immediately. ZSH template changes require `make zsh`.
