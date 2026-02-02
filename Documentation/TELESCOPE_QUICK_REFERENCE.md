# Telescope Extensions Quick Reference

## 🔍 Search Pickers (Press These + Search)

| Keymap | Opens | Use For |
|--------|-------|---------|
| `<leader>sr` | Registers | Browse & paste from all registers |
| `<leader>sc` | Commands | Find and run any command |
| `<leader>sp` | Command Palette | Command discovery with UI |
| `<C-M-p>` | Command Palette (Alt) | Alternative command palette |
| `<leader>sh` | Help Tags | Browse Neovim documentation |
| `<leader>sk` | Keymaps | Discover all keybindings |
| `<leader>s/` | Search History | Rerun previous searches |
| `<leader>s:` | Command History | Rerun previous commands |
| `<leader>sch` | Highlights | View colorscheme colors |
| `<leader>sq` | Quickfix | Navigate errors/warnings |
| `<leader>sl` | Location List | Jump to specific locations |

---

## ⌨️ Controls Inside Telescope

| Key | Action |
|-----|--------|
| `j` / `k` | Move down / up |
| `/` | Filter results |
| `<C-n>` | Next result |
| `<C-p>` | Previous result |
| `<CR>` | Select (default action) |
| `<C-s>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<Esc>` | Close picker |
| `<C-c>` | Close picker (alternative) |

---

## 🎯 Common Search Patterns

### Find Specific Command Types
```
<leader>sc
write       → Find all write-related commands
format      → Find formatting commands
lsp         → Find LSP commands
diag        → Find diagnostic commands
buffer      → Find buffer commands
window      → Find window commands
search      → Find search commands
```

### Find Specific Help Topics
```
<leader>sh
motion      → Learn about motions
autocmd     → Learn autocommands
function    → Learn about functions
lua         → Lua scripting in Neovim
builtin     → Built-in functions
variable    → Neovim variables
option      → Options (settings)
```

### Find Specific Keymaps
```
<leader>sk
leader      → Show all leader keybindings
window      → Show window keybindings (w)
buffer      → Show buffer keybindings (b)
telescope   → Show telescope keybindings
lsp         → Show LSP keybindings
```

---

## 💡 Workflow Examples

### Example 1: Copy Old Data from Register
```
1. <leader>sr        # Open registers
2. Type: a           # Find register 'a'
3. <CR>              # Paste it
4. Done!
```

### Example 2: Find and Run a Command
```
1. <leader>sc        # Open commands
2. Type: terminal    # Search for terminal
3. <C-j>             # Select :terminal
4. <CR>              # Run it
```

### Example 3: Learn About Folds
```
1. <leader>sh        # Open help
2. Type: fold        # Search for fold
3. <CR>              # Jump to documentation
4. Read and learn!
```

### Example 4: Find a Keymap
```
1. <leader>sk        # Open keymaps
2. Type: split       # Find split-related
3. <CR>              # Jump to it
```

### Example 5: Rerun Last Search
```
1. <leader>s/        # Search history
2. <CR>              # Rerun last search
   (or arrow/search to find the one you want)
```

---

## 🚀 Pro Tips

**Tip 1: Multiple Word Search**
```
Type in picker: "lsp diag"
Matches both "lsp" and "diag" in results
```

**Tip 2: Split Opening**
```
While in picker:
<C-v>          Open result in vertical split
<C-s>          Open result in horizontal split
<C-t>          Open result in new tab
```

**Tip 3: Quick History Rerun**
```
<leader>s:     Command history
<C-j>          Go to previous
<CR>           Rerun command
```

**Tip 4: Help Documentation Combo**
```
<leader>sh
Type: usr_01
Jumps to User Manual Chapter 1
```

**Tip 5: Registers for Macros**
```
1. <leader>sr
2. Find register with your macro
3. <CR> to paste it into buffer
4. Edit and perfect it
```

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Picker is empty | `:checkhealth telescope` |
| Keybindings not working | `<leader>sk` to verify they're mapped |
| Results take too long | Results are using fuzzy matching (normal) |
| Registers show nothing | `:registers` to verify in command line |
| Commands don't show | `:command` to see all commands |

---

## 📊 Telescope Cheat Sheet

**In One Image**:

```
<leader>sr ──────→ Registers (copy/paste)
<leader>sc ──────→ Commands (find & run)
<leader>sp ──────→ Command Palette (discover)
<leader>sh ──────→ Help (learn)
<leader>sk ──────→ Keymaps (discover bindings)
<leader>s/ ──────→ Search History (reuse)
<leader>s: ──────→ Command History (reuse)
<leader>sch ─────→ Colors (preview theme)
<leader>sq ──────→ Errors (navigate)
<leader>sl ──────→ Locations (jump)

Inside Picker:
j/k       = Move
/         = Filter
<CR>      = Select
<C-v>     = Vertical Split
<C-s>     = Horizontal Split
<Esc>     = Close
```

---

## 🎓 Next Level Usage

### Combine with Other Features
```
1. <leader>sc (find command)
2. <leader>sk (find keybinding for it)
3. Create your own workflow!
```

### Explore Hidden Commands
```
1. <leader>sc (open commands)
2. Search: ":"
3. See ALL available commands
4. Discover things you didn't know about!
```

### Learn Neovim
```
1. <leader>sh (open help)
2. Browse documentation
3. Follow the "see also" sections
4. Build knowledge gradually
```

---

## ✅ Quick Start (30 seconds)

```
1. Press: <leader>sr
   → See what registers contain
   → Try pasting one

2. Press: <leader>sc
   → Search for "write"
   → See what write commands exist

3. Press: <leader>sh
   → Search for "motion"
   → Learn about motions

4. Press: <leader>sk
   → Search for "window"
   → See all window keybindings

Congratulations! You've learned Telescope! 🎉
```

---

## 📚 Learn More

```vim
:help telescope              Main Telescope docs
:help telescope.builtin     Built-in pickers
:Telescope help_tags        Browse help interactively
<leader>sk                  Find keybinding for any action
```

---

**File**: `lua/plugins/telescope-extensions.lua`  
**Status**: ✅ Production Ready  
**Last Updated**: 2025

Created: `Telescope Extensions Quick Reference.md`
