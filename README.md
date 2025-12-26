# Neovim Configuration - Terminal Centric Workflow

A comprehensive, modern, and performant Neovim configuration optimized for terminal-centric development.

## 🎯 Features

### Core Setup
- ✅ **FISH Shell Integration** - Default shell with proper terminal bindings
- ✅ **Space as Leader** - Mnemonic, intuitive keybindings
- ✅ **Performance Optimized** - Fast startup, lazy-loaded plugins
- ✅ **Modular Architecture** - Well-organized, maintainable code

### Development Tools
- ✅ **LSP Support** - Full language server protocol implementation with 10+ servers
- ✅ **TreeSitter** - Advanced syntax highlighting and text objects
- ✅ **Smart Autocompletion** - nvim-cmp with LSP, buffer, path, and snippet sources
- ✅ **Code Snippets** - LuaSnip with friendly-snippets and custom snippet creation
- ✅ **Telescope Suite** - Fuzzy finder for files, grep, buffers, symbols, and more
- ✅ **CodeCompanion** - GitHub Copilot integration for AI-assisted coding
- ✅ **Git Integration** - Fugitive and Gitsigns for comprehensive git workflow

### Navigation & Motion
- ✅ **Leap.nvim** - AceJump-style character jumping with 's' and 'S'
- ✅ **Project Management** - Auto-detect projects, smart workspace handling
- ✅ **Smart Window Management** - Right-oriented splits, easy navigation

### UI & Aesthetics
- ✅ **Catppuccin Theme** - Beautiful, minimal color scheme
- ✅ **Lualine** - Clean, informative status line
- ✅ **Which-Key** - Interactive keymap explorer
- ✅ **Semantic Highlighting** - Context-aware syntax coloring

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/             # Core configuration
│   │   ├── settings.lua     # Editor options and globals
│   │   ├── keymaps.lua      # Leader-based keybindings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── autocmds.lua     # Autocommands and event handlers
│   │   └── shell.lua        # FISH shell integration
│   ├── plugins/            # Plugin-specific configurations
│   │   ├── ui/
│   │   │   ├── catppuccin.lua
│   │   │   └── lualine.lua
│   │   ├── editor/
│   │   │   ├── comment.lua
│   │   │   ├── autopairs.lua
│   │   │   └── which-key.lua
│   │   ├── treesitter.lua
│   │   ├── telescope.lua
│   │   ├── completion.lua
│   │   ├── snippets.lua
│   │   ├── codecompanion.lua
│   │   ├── project.lua
│   │   ├── lsp/
│   │   │   └── mason.lua
│   │   ├── motion/
│   │   │   └── leap.lua
│   │   └── git/
│   │       └── gitsigns.lua
│   ├── lsp/                # Language server configurations
│   │   └── setup.lua       # LSP initialization and attach handler
│   └── utils/              # Utility functions (for future use)
└── README.md              # This file
```

## ⌨️ Keybindings

### Leader Key: Space

#### Window Management (`<leader>w`)
- `<leader>wh/j/k/l` - Navigate windows (hjkl)
- `<leader>wv` - Vertical split
- `<leader>ws` - Horizontal split
- `<leader>wn` - New window
- `<leader>wc` - Close window
- `<leader>w=` - Equalize sizes
- `<leader>w+/-/>/<` - Resize

#### Buffer Management (`<leader>b`)
- `<leader>bn` - New buffer
- `<leader>bd` - Delete buffer
- `<leader>bl/h` - Next/previous buffer
- `<leader>ba` - Delete all others

#### File Operations (`<leader>f`)
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `<leader>fp` - Projects
- `<leader>fs/S` - Save/save all
- `<leader>fe` - Reload file

#### LSP (`<leader>l`)
- `gd` - Goto definition
- `gD` - Goto declaration
- `gI` - Goto implementation
- `gr` - References
- `K` - Hover documentation
- `<leader>la` - Code actions
- `<leader>lr` - Rename symbol
- `<leader>ld` - Show diagnostics
- `[d/]d` - Previous/next diagnostic

#### Search & Navigation
- `s/S` - Leap forward/backward (AceJump style)
- `n/N` - Next/previous search result (centered)
- `/` - Search forward

#### Motion & Editing
- `jj/jk` - Escape insert mode
- `<C-u/d>` - Page up/down (centered)
- `<` / `>` - Indent/dedent in visual mode
- `J/K` - Move lines in visual mode

### Terminal Mode
- `<Esc>` - Exit terminal mode
- `<C-h/j/k/l>` - Navigate from terminal

## 🚀 Quick Start

### Prerequisites
```bash
# Install Neovim (0.9+)
brew install neovim          # macOS
sudo apt install neovim      # Ubuntu/Debian
pacman -S neovim             # Arch

# Install FISH shell
brew install fish            # macOS
sudo apt install fish        # Ubuntu/Debian

# Install required tools
npm install -g neovim       # For Node.js support
pip install pynvim          # For Python support
```

### Installation

1. **Clone/Update Configuration**
   ```bash
   # If starting fresh, the config is already in ~/.config/nvim
   cd ~/.config/nvim
   git status
   ```

2. **First Run**
   ```bash
   nvim
   # Lazy.nvim will auto-install plugins
   # Mason will auto-install language servers
   ```

3. **Verify Installation**
   ```vim
   :Mason                    " Check installed servers
   :checkhealth             " Run health checks
   ```

## 🔧 Configuration

### Adding New Language Servers
Edit `lua/lsp/setup.lua` and add the server to `mason_lspconfig.ensure_installed`:
```lua
ensure_installed = {
  "lua_ls",
  "your_new_server",  -- Add here
}
```

### Creating Custom Snippets
In any file:
```vim
:SnippetCreate
```

Then edit `~/.config/nvim/snippets/{filetype}.json`

### Customizing Theme
Edit `lua/plugins/ui/catppuccin.lua`:
```lua
flavour = "latte",  -- or "frappe", "macchiato", "mocha"
```

### Adding More Plugins
Edit `lua/config/lazy.lua` and add to the `plugins` table:
```lua
{
  "author/plugin-name",
  event = "VeryLazy",
  config = function()
    require("plugin-config")
  end,
}
```

## 📊 Performance

The configuration is optimized for fast startup and responsive editing:
- **Lazy Loading**: Plugins load on-demand (events, commands, keys)
- **Minimal Core**: Only essential plugins on startup
- **Optimized Settings**: Synmaxcol, lazyredraw, efficient diagnostics
- **Smart Caching**: Undo directory, persistent state

Startup time: **~50-100ms** (measured with `vim --startuptime`)

## 📝 Documentation

Each module includes comprehensive inline documentation:
- Clear section headers (━━━)
- Feature explanations
- Usage examples

## 🎓 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://neovim.io/doc/user/lua.html)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Which-Key Docs](https://github.com/folke/which-key.nvim)

## 🤝 Extending

The configuration is designed to be easily extended:

1. **Add custom utilities** in `lua/utils/`
2. **Create plugin configs** in `lua/plugins/`
3. **Extend LSP** in `lua/lsp/`
4. **Add keybindings** in `lua/config/keymaps.lua`

## 🐛 Troubleshooting

### Plugins not installing
```vim
:Lazy sync
:Mason
```

### LSP not working
```vim
:checkhealth nvim_lsp
:LspInfo
```

### Slow startup
```vim
:profile start /tmp/nvim.log
:profile func *
" Do work...
:profile stop
" Check /tmp/nvim.log
```

## 📄 License

This configuration is provided as-is for personal use. Feel free to modify and share.

---

**Happy coding!** 🚀
