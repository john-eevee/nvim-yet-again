# Neovim Configuration - Start Here

Welcome to your comprehensive, modern Neovim configuration optimized for terminal-centric development!

## 📖 Quick Navigation

- **[README.md](README.md)** - Complete documentation with all features and keybindings
- **[CHEATSHEET.md](CHEATSHEET.md)** - Quick reference for most-used commands

## ⚡ Quick Start

1. **First Run**
   ```bash
   nvim
   # Plugins auto-install on first run
   ```

2. **Verify Setup**
   ```vim
   :checkhealth        " Check everything is working
   :Mason              " View installed language servers
   ```

3. **Start Using**
   - `<leader>ff` - Find files
   - `<leader>fg` - Search code
   - `s` - Jump to character (AceJump style)
   - `<leader>?` - Show all keybindings

## 🎯 Key Features at a Glance

### Coding
- **LSP**: Full language server support with 15+ auto-installed servers
- **Completion**: Smart autocompletion with LSP, snippets, and buffers
- **Formatting**: Auto-format on save with Conform.nvim
- **Linting**: Async linting with multiple linters per language

### Navigation
- **Telescope**: Fuzzy find files, search code, jump to symbols
- **Leap**: AceJump-style jumping with `s` and `S`
- **Project**: Auto-detect and switch projects
- **Windows**: Easy split navigation with `<leader>w`

### Git
- **Fugitive**: Git commands in Neovim
- **Gitsigns**: Show changes, blame, stage hunks
- **Status**: Git info in status line

### AI
- **Copilot**: GitHub Copilot integration with `<leader>cc`

### UI
- **Theme**: Beautiful Catppuccin color scheme
- **Status Line**: Clean Lualine with git and diagnostics
- **Notifications**: Beautiful notification windows
- **Diagnostics**: Pretty error/warning list with Trouble.nvim

## 📁 File Organization

```
lua/config/          - Core configuration
lua/plugins/         - Plugin-specific setup
lua/lsp/            - Language server configuration
lua/utils/          - Helper functions
```

## 🔧 Common Tasks

### Install More Language Servers
Edit `lua/plugins/lsp/mason.lua` and add to `ensure_installed` list.

### Create Code Snippets
```vim
:SnippetCreate
" Then edit ~/.config/nvim/snippets/{filetype}.json
```

### Add Custom Keybinding
Edit `lua/config/keymaps.lua` or `lua/config/keymap_extended.lua`

### Switch Color Scheme
```vim
:colorscheme {name}
" Or press <leader>uc for menu
```

## 📊 Plugin Summary

**Total Plugins**: 30+

### By Category
- **UI**: Catppuccin, Lualine, Which-Key, Notify
- **Editor**: Comment, Autopairs, Mini.nvim suite
- **Completion**: Cmp, LuaSnip, Friendly-snippets
- **LSP**: Neovim LSP, Mason, Conform, Nvim-lint
- **Search**: Telescope, Leap, Trouble, Project
- **Git**: Fugitive, Gitsigns
- **Treesitter**: Syntax, text objects, context
- **AI**: CodeCompanion (Copilot)

## 🚀 Performance

- **Startup Time**: 50-100ms (measured with `:ProfileStart/:ProfileStop`)
- **Lazy Loading**: Plugins load on-demand (events, commands, keys)
- **Optimization**: Minimal core, smart caching, efficient diagnostics

## 📚 Learning Resources

### In Vim
- Press `<leader>?` to see all available keybindings
- Hover over commands for descriptions
- Type `:help {topic}` for comprehensive help

### External
- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Configuration](https://neovim.io/doc/user/lsp.html)
- [Lua Guide](https://neovim.io/doc/user/lua.html)

## 🆘 Troubleshooting

### Nothing works?
```vim
:checkhealth           " Diagnose issues
:Mason                 " Check servers
```

### Slow performance?
```vim
:ProfileStart
" ... do some work ...
:ProfileStop
" Check /tmp/nvim_profile.log
```

### Plugins not loading?
```vim
:Lazy sync
:LazyStatus
```

## 💡 Pro Tips

1. **Search**: `<leader>fg` then edit pattern in-place for powerful grep
2. **Navigate**: Press `s` then type character to jump (like AceJump)
3. **Copilot**: `<leader>cc` to open chat, `<leader>ca` for code actions
4. **Format**: `<leader>lf` to auto-format with configured formatter
5. **Blame**: `<leader>gb` to see who changed each line
6. **Terminal**: `<leader>ts`, `<leader>tv` to open terminal splits
7. **Sessions**: `<leader>ss` to save, `<leader>sr` to restore session
8. **Focus**: `<leader>um` to toggle minimal mode for distraction-free editing

## 🔄 Git Workflow

Each feature is committed separately for easy tracking:

```bash
git log --oneline       # See all changes
git show HEAD           # View latest commit details
```

Look at commit messages for what was implemented in each step.

## 📞 Need Help?

1. Check **README.md** for complete documentation
2. Check **CHEATSHEET.md** for quick commands
3. Press `<leader>?` in Vim for keybinding help
4. Run `:checkhealth` to diagnose issues

## ✨ Highlights

- ✅ **Modern** - Uses latest Neovim features and plugins
- ✅ **Fast** - Optimized startup and responsive editing
- ✅ **Terminal-Ready** - FISH shell integration
- ✅ **Well-Organized** - Modular, documented code
- ✅ **Extensible** - Easy to add plugins and customize
- ✅ **Productive** - Keyboard-focused, mnemonic keybindings
- ✅ **Beautiful** - Catppuccin theme, clean UI
- ✅ **Git-Friendly** - Step-by-step commits

---

**Happy coding!** 🚀

For questions or issues, consult README.md or check the commit history to understand each component.
