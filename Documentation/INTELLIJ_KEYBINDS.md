# IntelliJ-Style Keybinds Reference

**Last Updated:** 2026-03-25  
**Timeout:** 5000ms (increased for longer chord sequences)  
**Leader Key:** `\` (backslash, freed from `<Space>`)

---

## Navigation & File Discovery

### Finding Files & Text

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<C-S-n>` | Find Files | Ctrl+Shift+N |
| `<C-S-f>` | Live Grep (Find in Path) | Ctrl+Shift+F |
| `<C-e>` | Recent Files/Buffers | Ctrl+E |
| `<C-S-a>` | Command Palette | Ctrl+Shift+A |
| `<C-A-k>` | Keymaps Search | — |

### Buffer Navigation

| Keybind | Action | Mode |
|---------|--------|------|
| `<A-Left>` | Previous Buffer | Normal |
| `<A-Right>` | Next Buffer | Normal |
| `<C-h>` | Previous Buffer (legacy) | Normal |
| `<C-l>` | Next Buffer (legacy) | Normal |
| `<C-F4>` | Close Buffer/Window | Normal |

---

## Code Navigation (LSP)

### Go To Actions

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<C-b>` | Go to Definition | Ctrl+B |
| `<C-S-b>` | Go to Declaration/Type Def | Ctrl+Shift+B |
| `<C-A-b>` | Go to Implementation | Ctrl+Alt+B |
| `<A-F7>` | Find Usages/References | Alt+F7 |
| `<C-F12>` | Document Symbols (Outline) | Ctrl+F12 |
| `<C-A-c>w` | Workspace Symbols | — |

### Code Actions & Refactoring

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<S-F6>` | Rename | Shift+F6 |
| `<C-A-l>` | Format Code | Ctrl+Alt+L |
| `<A-Enter>` | Code Action (Quick Fix) | Alt+Enter |
| `K` | Hover Docs | — |
| `<C-k>` | Signature Help | — |

---

## Debugging (DAP)

### Breakpoints & Execution

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<C-F8>` | Toggle Breakpoint | Ctrl+F8 |
| `<F7>` | Step Into | F7 |
| `<F8>` | Step Over | F8 |
| `<S-F8>` | Step Out | Shift+F8 |
| `<F9>` | Continue | F9 |
| `<A-F9>` | Run to Cursor | Alt+F9 |
| `<A-F8>` | Evaluate Expression | Alt+F8 |

---

## Testing (Neotest)

### Test Execution

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<C-S-F10>` | Run Nearest Test | Ctrl+Shift+F10 |
| `<S-F10>` | Run File Tests | Shift+F10 |
| `<S-F9>` | Debug Nearest Test | Shift+F9 |

---

## Window & Split Management

### Navigation Between Splits

| Keybind | Action |
|---------|--------|
| `<C-A-h>` | Navigate Left |
| `<C-A-j>` | Navigate Down |
| `<C-A-k>` | Navigate Up |
| `<C-A-l>` | Navigate Right |
| `<C-A-Left>` | Navigate Left (arrow variant) |
| `<C-A-Down>` | Navigate Down (arrow variant) |
| `<C-A-Up>` | Navigate Up (arrow variant) |
| `<C-A-Right>` | Navigate Right (arrow variant) |

### Creating & Manipulating Splits

| Keybind | Action |
|---------|--------|
| `<C-A-v>` | Split Vertical |
| `<C-A-s>` | Split Horizontal |
| `<C-A-w>` | Close Split |
| `<C-F4>` | Close Split (IntelliJ-style) |
| `<C-A-=>` | Equalize Split Sizes |

---

## Git Integration (Gitsigns)

### Hunk Operations

| Keybind | Action |
|---------|--------|
| `]h` | Next Hunk |
| `[h` | Previous Hunk |
| `<C-A-g>s` | Stage Hunk |
| `<C-A-z>` | Reset Hunk |
| `<C-A-g>p` | Preview Hunk |
| `<C-A-g>b` | Blame Line |
| `<C-A-g>d` | Diff This (current) |
| `<C-A-g>D` | Diff This (~) |

### Buffer-Level Operations

| Keybind | Action |
|---------|--------|
| `<C-A-g>S` | Stage Buffer |
| `<C-A-g>R` | Reset Buffer |
| `<C-A-g>u` | Undo Stage Hunk |

---

## Search & Replace

| Keybind | Action | IntelliJ Equiv |
|---------|--------|---|
| `<C-A-r>` | Search & Replace (GrugFar) | Ctrl+H |
| `<Esc>` | Clear Search Highlight | — |

---

## File Explorer

| Keybind | Action |
|---------|--------|
| `<C-A-e>` | Toggle Oil File Explorer |
| `<M-1>` | Toggle NeoTree |

---

## Navigation Bookmarks (Harpoon)

### Adding & Accessing Marks

| Keybind | Action |
|---------|--------|
| `<C-A-m>a` | Add File to Harpoon |
| `<C-A-h>` | Toggle Harpoon Menu |
| `<C-1>` | Jump to Harpoon Mark 1 |
| `<C-2>` | Jump to Harpoon Mark 2 |
| `<C-3>` | Jump to Harpoon Mark 3 |
| `<C-4>` | Jump to Harpoon Mark 4 |
| `<C-A-h>p` | Previous Mark in List |
| `<C-A-h>n` | Next Mark in List |

---

## UI Toggles

| Keybind | Action |
|---------|--------|
| `<C-A-r>` | Toggle Relative Line Numbers |
| `<C-A-w>` | Toggle Line Wrap |
| `<C-A-p>` | Toggle Spell Check |
| `<C-A-d>` | Toggle Diagnostics |
| `<C-A-\>` | Toggle Zen Mode |

---

## Other Utilities

### Todo Comments

| Keybind | Action |
|---------|--------|
| `]t` | Next Todo |
| `[t` | Previous Todo |
| `<C-A-t>d` | Search All Todos |
| `<C-A-t>f` | Search TODO/FIX/FIXME |

### Rust Tools

*Only available in Rust files (`:set ft=rust`)*

| Keybind | Action |
|---------|--------|
| `<C-A-u>r` | Runnables (cargo run/test) |
| `<C-A-u>d` | Debuggables (LLDB) |
| `<C-A-u>e` | Expand Macro |
| `<C-A-u>p` | Parent Module |
| `<C-A-u>j` | Join Lines |
| `<C-A-u>s` | Structural Search & Replace |

### Database (SQL)

| Keybind | Action |
|---------|--------|
| `<C-A-d>b` | Toggle DB UI |

### Alternate Files

| Keybind | Action |
|---------|--------|
| `<C-A-o>a` | Open Alternate File |
| `<C-A-o>s` | Open Alternate in Split |
| `<C-A-o>v` | Open Alternate in Vsplit |

### Miscellaneous

| Keybind | Action |
|---------|--------|
| `<C-A-j>` | Jump2d Start |
| `<C-A-x>` | Toggle Diff Overlay |
| `<C-A-m>r` | Run Mise Task (ui.select) |
| `<C-A-m>R` | Run Mise Task (telescope) |

---

## Native Vim Motions (Unchanged)

These core Vim motions remain standard and are not affected by the keybind migration:

| Keybind | Action |
|---------|--------|
| `h`, `j`, `k`, `l` | Move Left, Down, Up, Right |
| `w`, `b` | Move Word Forward/Backward |
| `f{char}`, `F{char}` | Find Character |
| `s` | Flash Jump (Easymotion-like) |
| `*`, `#` | Search Word Forward/Backward |
| `n`, `N` | Next/Previous Search (centered) |
| `u` | Undo |
| `<C-r>` | Redo |
| `d`, `c`, `y` | Delete, Change, Yank |
| `p`, `P` | Paste After/Before |
| `gd` (in plugins) | Go to Definition (remapped from `:lsp`) |

---

## Which-Key Integration

All keybinds are registered with **Which-Key**, so you can:

1. **Press any Ctrl+Alt chord** and wait ~1s to see available sub-commands
2. **Press a key sequence prefix** to see what commands start with that chord
3. Example: Press `<C-A-g>` and you'll see all Git sub-commands:
   - `<C-A-g>s` → Stage Hunk
   - `<C-A-g>p` → Preview Hunk
   - etc.

### Which-Key Groups

| Group | Prefix | Commands |
|-------|--------|----------|
| Alt Commands | `<C-A-a>` | — |
| Colors/Check | `<C-A-c>` | Highlights, Workspace Symbols |
| Database | `<C-A-d>` | Toggle DB UI |
| Explorer | `<C-A-e>` | Oil file explorer |
| Git | `<C-A-g>` | Stage, Reset, Preview, Blame, Diff |
| Harpoon | `<C-A-h>` | Menu, Next, Prev, Add |
| Jump | `<C-A-j>` | Jump2d |
| Keymaps | `<C-A-k>` | Search keymaps |
| Format | `<C-A-l>` | Format, Loclist |
| Mise | `<C-A-m>` | Run task |
| Other | `<C-A-o>` | Alternate files |
| Pause/Spell | `<C-A-p>` | Toggle spell |
| Quickfix | `<C-A-q>` | Quickfix list |
| Replace | `<C-A-r>` | GrugFar, Relative numbers |
| Split/Session | `<C-A-s>` | Splits, test summary |
| Todo/Test | `<C-A-t>` | Todo search, test commands |
| Utils | `<C-A-u>` | DAP, REPL, Rust tools |
| Wrap/Widgets | `<C-A-w>` | Line wrap, DAP widgets |
| Diff | `<C-A-x>` | Toggle diff overlay |
| Zen/Reset | `<C-A-z>` | Zen mode, Reset hunk |

---

## Tips for Switching from LazyVim Defaults

### Before → After

| Old (Space-Leader) | New (Direct Chord) | Context |
|----|----|----|
| `<Space>ff` | `<C-S-n>` | Find Files |
| `<Space>fg` | `<C-S-f>` | Live Grep |
| `<Space>fb` | `<C-e>` | Recent Files |
| `<Space>sr` | `<C-A-r>` | Search & Replace |
| `<Space>wh/wj/wk/wl` | `<C-A-h/j/k/l>` | Window Navigation |
| `<Space>bd` | `<C-F4>` | Close Buffer |
| `<Space>uh/uw/us` | `<C-A-r/w/p>` | UI Toggles |

---

## Discovering More Commands

### Use Telescope's Keymaps Picker

```vim
:Telescope keymaps
" or
<C-A-k>
```

This shows all registered keybinds with descriptions. Search for:
- `Ctrl+Alt` to see all new binds
- `F7`, `F8`, `F9` to see debug binds
- `LSP` to see language server commands
- `Git` to see version control commands

### Interactive Which-Key

Just **start typing a chord** and pause for ~1 second. Which-Key will show:
- Available subcommands
- Descriptions
- Full key sequence needed

---

## Frequently Asked Questions

### Q: Where did the space leader go?
**A:** Space (`<Space>`) is now free for custom bindings. The leader key is now `\` (backslash), but is rarely used since all commands are direct chords.

### Q: Why Ctrl+Alt for Neovim-specific features?
**A:** Ctrl+Alt combos are less likely to conflict with applications or IntelliJ plugins, while preserving standard IDE shortcuts (Ctrl+B, F7-F9, etc.).

### Q: How do I remember all these keybinds?
**A:** Use **Which-Key** — just press any Ctrl+Alt chord and wait. Or search `:Telescope keymaps`.

### Q: Can I customize these keybinds?
**A:** Yes! Edit the files listed in the config:
- Core navigation: `lua/config/keymaps.lua`
- LSP & plugins: `after/plugin/keymaps.lua`
- Specific plugins: `lua/plugins/*.lua` (search `keys = {`)

### Q: Why 5000ms timeout?
**A:** Multi-chord sequences (like `<C-A-g>s`) need time between keystrokes. 5s is generous but not slow.

### Q: Do I lose Vim's standard motions?
**A:** No! All standard Vim motions (`hjkl`, `w`, `b`, `f`, etc.) are unchanged.

---

## See Also

- [VIM_MOTIONS_CHEATSHEET.md](./VIM_MOTIONS_CHEATSHEET.md) — Standard Vim motions
- `lua/config/keymaps.lua` — Core keybind definitions
- `after/plugin/keymaps.lua` — Plugin-specific keybinds
- `:help keymap` — Vim's built-in keymap documentation
