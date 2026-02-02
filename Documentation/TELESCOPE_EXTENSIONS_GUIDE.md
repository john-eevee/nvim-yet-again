# Telescope Extensions Guide

## 📡 Overview

This guide covers the advanced Telescope extensions added for enhanced productivity and searching capabilities in Neovim.

## 🎯 What Are Telescope Extensions?

Telescope is the fuzzy finder plugin in your Neovim setup. Extensions add specialized search capabilities beyond the built-in file/text searching.

### Extensions Installed

1. **telescope-registers** - Browse and paste from all Neovim registers
2. **telescope-command-palette** - Command palette for running commands with descriptions
3. **Built-in Telescope pickers** - Commands, help tags, keymaps, search history, and more

---

## 📝 Complete Keymap Reference

### Registers & Clipboard
| Keymap | Action | Mode |
|--------|--------|------|
| `<leader>sr` | Open registers picker | Normal, Visual |

**Use Case**: Quickly access and paste from any register without typing `"a` or `"b` etc.

---

### Commands & Command Palette
| Keymap | Action |
|--------|--------|
| `<leader>sc` | Browse all available commands |
| `<leader>sp` | Command palette (builtin) |
| `<C-M-p>` | Command palette (LinArcX) |

**Use Cases**: 
- Find and run any command by name
- Discover available commands
- Quick access to complex commands you rarely remember

---

### Documentation & Help
| Keymap | Action |
|--------|--------|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Browse keymaps |
| `<leader>s/` | Search history |
| `<leader>s:` | Command history |

**Use Cases**:
- Quickly find Neovim documentation
- Discover available keybindings
- Review previous searches or commands

---

### Diagnostics & Navigation
| Keymap | Action |
|--------|--------|
| `<leader>sch` | Browse syntax highlights |
| `<leader>sq` | Quickfix list |
| `<leader>sl` | Location list |

**Use Cases**:
- Understand current colorscheme colors
- Navigate to errors/warnings in project
- Jump to specific locations

---

## 🔍 Detailed Usage Examples

### Using Registers Picker

```
<leader>sr              Open registers
  - See all registers with their contents
  - Type to filter by register name
  - Press <CR> to paste the register content
  - In visual mode, pastes the register over selection
```

**Register Types**:
- Named registers: `a` through `z`
- Read-only registers: `.` (last inserted), `-` (small delete), `%` (current file), `:` (last command)
- Selection registers: `*` (primary), `+` (clipboard)
- Search register: `/` (last search pattern)

**Example Workflow**:
```
1. Copy some code into register 'a'
2. Later, press <leader>sr
3. Type 'a' to find register a
4. Press <CR> to paste it
```

---

### Using Commands Picker

```
<leader>sc              Open commands picker
  - Lists all available commands
  - Shows command descriptions
  - Fuzzy search to find what you need
  - Press <CR> to execute
```

**Example Search Patterns**:
```
:search            Find all search-related commands
:write             Find write/save commands
:lsp               Find LSP-related commands
:toggle            Find toggle commands
```

---

### Using Help Tags

```
<leader>sh              Open help tags picker
  - Browse entire Neovim documentation
  - Search for specific topics
  - Navigate to help sections instantly
```

**Example Searches**:
```
:help              General help overview
:motion            Find motion-related topics
:autocmd           Learn about autocommands
:diagnostic        Diagnostic system help
```

---

### Using Keymaps Browser

```
<leader>sk              Open keymaps picker
  - See ALL configured keybindings
  - Discover keymaps you forgot about
  - Search by action or keymap
  - Shows what each key does
```

**Useful Searches**:
```
:leader            See all leader keybindings
:window            See window management keys
:buffer            See buffer navigation keys
```

---

### Using Search & Command History

```
<leader>s/              Previous searches
  - Rerun previous searches
  - Browse search patterns
  - Re-use complex patterns

<leader>s:              Previous commands
  - Rerun previous commands
  - Browse command history
  - Copy complex commands
```

---

## 🚀 Workflow Examples

### Workflow 1: Quickly Rename Something

```
1. Go to symbol you want to rename
2. <leader>ca (code action)
3. Or use <leader>sc to find :rename command
4. Type new name
```

### Workflow 2: Forgotten a Keybinding?

```
1. <leader>sk (keymaps picker)
2. Type what you're looking for (e.g., "window")
3. See all window-related keybindings
4. Press <CR> on the one you want to try
```

### Workflow 3: Paste from Old Clipboard

```
1. <leader>sr (registers picker)
2. Type 'a' (or whatever register you used)
3. <CR> to paste the content
4. Much faster than typing " a p
```

### Workflow 4: Find a Command You Vaguely Remember

```
1. <leader>sc (commands picker)
2. Type keywords: "write" "fold" "format" etc.
3. See matching commands with descriptions
4. Select and run one
```

### Workflow 5: Learn What's Available

```
1. <leader>sh (help tags)
2. Browse alphabetically or search
3. Jump to documentation
4. Learn new features
```

---

## 🎨 Telescope Extensions Configuration

### Current Configuration

Located in: `lua/plugins/telescope-extensions.lua`

**Registers Extension Options**:
```lua
registers = {
  show_empty = false,  -- Don't show empty registers
}
```

**To Customize**:
1. Open `lua/plugins/telescope-extensions.lua`
2. Modify the `registers` table
3. Restart Neovim
4. Changes take effect immediately

---

## 📊 Integration with Other Features

### With LSP
```
<leader>ca              Code actions (also available via commands)
<leader>sc              Find LSP-related commands
```

### With Navigation
```
<leader>sk              Find navigation keybindings
<leader>sl              Jump to location list items
<leader>sq              Navigate quickfix errors
```

### With Search
```
<leader>s/              Reuse previous searches
<leader>sh              Find search-related help
```

---

## 🔧 Troubleshooting

### Issue: Telescope picker appears empty

**Solution**:
```vim
:checkhealth telescope
:LspInfo
:Mason
```

### Issue: Keybindings not working

**Solution**:
```vim
<leader>sk              Search for the keymap you want
:lua vim.notify(vim.inspect(vim.keymap.get(0)))  " Show all keymaps
```

### Issue: Registers not showing content

**Solution**:
```vim
:registers              Show registers in command line
:Telescope registers    Try registers picker
```

### Issue: Command palette doesn't load

**Solution**:
```vim
:Telescope commands            Try commands picker instead
:Telescope command_palette     Try command palette
```

---

## 💡 Pro Tips

### Tip 1: Search History is Your Friend
```
Use <leader>s/ and <leader>s: to:
- Find complex patterns you created before
- Rerun common searches without retyping
- Avoid reinventing complex regex
```

### Tip 2: Help Tags for Learning
```
<leader>sh and search:
- usr_      (user manual chapters)
- autocmd   (auto commands)
- eval      (expressions and functions)
- builtin   (built-in functions)
```

### Tip 3: Keymaps for Discovery
```
<leader>sk lets you:
- Type "diag" to find all diagnostic keybindings
- Type "format" to see formatting commands
- Type "test" to find test-running keybindings
```

### Tip 4: Combine with Search
```
In any picker:
- Type multiple words to search simultaneously
- Use <C-n>/<C-p> to navigate results
- Use <C-s>, <C-v>, <C-t> for split/vsplit/tab opening
```

### Tip 5: Registers for Macros
```
After recording macro in register 'a':
1. <leader>sr
2. Search for 'a'
3. See your macro content
4. <CR> to paste it into buffer
5. Edit and refine
```

---

## 🔄 Advanced Usage

### Piping Telescope Results

In Telescope picker:
- `<C-s>` - Open in horizontal split
- `<C-v>` - Open in vertical split  
- `<C-t>` - Open in new tab
- `<CR>` - Default action

### Custom Telescope Workflows

You can create custom commands that combine Telescope pickers:

```lua
-- Example: Find all diagnostic-related commands
<leader>sc
Type: :diag

-- Example: Find all LSP commands
<leader>sc
Type: :lsp
```

---

## 📚 Related Documentation

- Telescope Documentation: `:help telescope`
- Registers: `:help registers`
- Commands: `:help :command`
- Keymaps: `:help :map`
- Quickfix: `:help quickfix`

---

## 🎯 Next Steps

### To Further Enhance:

1. **Add Custom Pickers** - Create your own Telescope pickers
2. **Custom Keymaps** - Bind Telescope to custom search patterns
3. **Integration** - Connect Telescope with other plugins
4. **Performance** - Use fzf-native for faster searching

### To Learn More:

```vim
<leader>sh telescope              See all telescope help
<leader>sc telescope              Find telescope commands
:Telescope                         List all pickers
```

---

## 📋 Quick Reference Card

**Save this command reference:**

```
SEARCH PICKERS:
  <leader>sr    Registers
  <leader>sc    Commands
  <leader>sp    Command Palette
  <leader>sh    Help Tags
  <leader>sk    Keymaps
  <leader>s/    Search History
  <leader>s:    Command History
  <leader>sch   Highlights
  <leader>sq    Quickfix
  <leader>sl    Location List

NAVIGATION IN PICKER:
  j/k           Move up/down
  /             Search
  <C-n>/<C-p>   Next/Previous result
  <CR>          Select
  <Esc>         Close picker

OPENING RESULTS:
  <CR>          Default action
  <C-s>         Horizontal split
  <C-v>         Vertical split
  <C-t>         New tab
```

---

## 🎓 Learning Resources

### From Telescope:
```vim
:Telescope help_tags
Search: telescope

:Telescope builtin
See all available pickers
```

### From Neovim:
```vim
:help telescope
:help 'helpheight'
:help registers
:help :command
```

### External Resources:
- [Telescope GitHub](https://github.com/nvim-telescope/telescope.nvim)
- [Telescope Wiki](https://github.com/nvim-telescope/telescope.nvim/wiki)
- [Telescope Documentation](https://github.com/nvim-telescope/telescope.nvim#documentation)

---

## ✅ Checklist: Getting Started with Telescope Extensions

- [ ] Understand what Telescope is (fuzzy finder)
- [ ] Learn all 10+ keybindings
- [ ] Try `<leader>sr` to browse registers
- [ ] Try `<leader>sc` to find commands
- [ ] Try `<leader>sh` to search help
- [ ] Try `<leader>sk` to see all keymaps
- [ ] Use `<leader>s/` to rerun a search
- [ ] Combine with splits: `<C-v>` in picker
- [ ] Create a custom workflow
- [ ] Explore help tags with `<leader>sh`

---

**Last Updated**: 2025  
**Status**: Production Ready ✅  
**File**: `lua/plugins/telescope-extensions.lua`
