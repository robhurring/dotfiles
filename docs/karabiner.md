# Karabiner-Elements

Keyboard customization for macOS. Config lives at `~/.config/karabiner/karabiner.json`
and is edited **directly** as JSON (Karabiner's native format).

> History: this used to be authored in `config/karabiner.edn` and compiled to JSON via
> [Goku](https://github.com/yqrashawn/GokuRakuJoudo). That setup drifted (Goku watcher
> never ran, profile name mismatch) so the `.edn` was dropped in favor of editing the
> JSON directly.

All rules live under the `Default profile` profile in
`complex_modifications.rules`. Reload via the Karabiner-Elements menu bar icon, or
toggle the profile, after editing.

## Base remap

| From | To |
|------|----|
| `caps_lock` | `left_control` |

## Simlayers

A "simlayer" turns a normal key into a layer when **held** while tapping another key,
but still types the key when **tapped alone** (200 ms timeout). Implemented with a
`set_variable` activator + `variable_if` conditioned bindings.

### f-mode — Focus / launch apps

Hold **`f`**, tap:

| Key | Action |
|-----|--------|
| `k` | Kitty |
| `s` | Slack |
| `w` | Google Chrome (web) |
| `i` | IntelliJ IDEA |
| `m` | Spotify |
| `o` | Obsidian |
| `a` | Todoist: add (`⌘⌃a`) |
| `l` | Todoist: open (`⌘⌃t`) |

### e-mode — Moom window management

Hold **`e`**, tap (each sends Moom's `⌃\` trigger + a key):

| Key | Action |
|-----|--------|
| `spacebar` | Full screen |
| `f` | Focus |
| `h` | Move left |
| `l` | Move right |
| `m` | Main |
| `return` | Return / revert |
| `[` | Detail left |
| `]` | Detail right |

### m-mode — Mouse keys

Hold **`m`**, tap:

| Key | Action |
|-----|--------|
| `w` / `a` / `s` / `d` | Move pointer up / left / down / right |
| `spacebar` / `q` | Left click |
| `e` | Right click |

### term-mode — tmux prefix (`⌃a`)

Active **only when Kitty or Ghostty is frontmost**. Hold **`;`** (semicolon), tap:

| Key | Sends | tmux meaning |
|-----|-------|--------------|
| `s` | `⌃a s` | choose session |
| `c` | `⌃a c` | new window |
| `h` | `⌃a p` | previous window |
| `l` | `⌃a n` | next window |
| `1`–`5` | `⌃a <n>` | select window n |
| `j` | `⌥j` | (pane nav) |
| `k` | `⌥k` | (pane nav) |

## Macropad (Hyper layer)

`Hyper` = `⌘⌃⌥⇧` (all four left modifiers), bound on a GeekBoard Macropad. These run
shell commands; the toggle scripts show/hide the app (raise if not frontmost, hide if
it is) via `bin/toggle-window.applescript`.

| Hyper + | Action | Mnemonic |
|---------|--------|----------|
| `s` | Toggle Slack | **s**lack |
| `t` | Toggle Ghostty | **t**erminal |
| `w` | Toggle Google Chrome | **w**eb |
| `a` | osascript smoke test (notification + speech) | — |

### toggle-window.applescript

```
osascript bin/toggle-window.applescript "<App Name>" ["<Process Name>"]
```

`Process Name` defaults to `App Name`; pass it explicitly when they differ — e.g. the
app is `Ghostty` but its process is lowercase `ghostty`.
