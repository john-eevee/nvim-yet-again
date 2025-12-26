# Neovim Configuration - Terminal Centric Workflow

A comprehensive, modern, and performant Neovim configuration optimized for terminal-centric development with AI integration, advanced LSP support, and minimal aesthetics.

## 🎯 Features

### Core Setup
- ✅ **FISH Shell Integration** - Default shell with proper terminal bindings
- ✅ **Space as Leader** - Mnemonic, intuitive keybindings
- ✅ **Performance Optimized** - Fast startup (~50-100ms), lazy-loaded plugins
- ✅ **Modular Architecture** - Well-organized, maintainable, extensible code
- ✅ **Mise-en-place Integration** - Automatic environment and tool management

### Development Tools & Coding
- ✅ **LSP Support** - Full language server protocol with 15+ auto-installed servers
  - Python (Pyright), Rust (rust-analyzer), Go (gopls), C/C++ (clangd)
  - TypeScript/JavaScript (ts_ls), HTML, CSS, JSON, YAML, Lua, Markdown
- ✅ **TreeSitter** - Advanced syntax highlighting, smart text objects, incremental selection
- ✅ **Smart Autocompletion** - nvim-cmp with LSP, buffer, path, and snippet sources
- ✅ **Code Snippets** - LuaSnip with friendly-snippets and custom snippet creation
- ✅ **Formatting** - Conform.nvim with auto-format on save (Prettier, Black, Stylua, etc.)
- ✅ **Linting** - Nvim-lint with async linting (Pylint, ESLint, Clippy, etc.)

### Search, Navigation & Motion
- ✅ **Telescope Suite** - Fuzzy finder for files, grep, buffers, LSP symbols, projects
- ✅ **Leap.nvim** - AceJump-style character jumping with 's' and 'S'
- ✅ **Mini.nvim Collection** - Surround, AI text objects, move lines, align, sessions
- ✅ **Project Management** - Auto-detect projects, smart workspace handling
- ✅ **Smart Window Management** - Right-oriented splits, easy navigation
- ✅ **Quickfix/Location Lists** - Trouble.nvim for pretty diagnostics
- ✅ **Treesitter Context** - Show scope context at top of screen

### AI & Assistant
- ✅ **CodeCompanion** - GitHub Copilot integration for AI-assisted coding
- ✅ **Context-Aware** - Copilot with full buffer context for smarter suggestions

### UI & Aesthetics
- ✅ **Catppuccin Theme** - Beautiful, minimal color scheme (mocha flavour)
- ✅ **Lualine** - Clean, informative status line with git info and diagnostics
- ✅ **Which-Key** - Interactive keymap explorer with helpful descriptions
- ✅ **Semantic Highlighting** - Context-aware syntax coloring with TreeSitter
- ✅ **Minimal Mode** - Toggle UI elements for focused, distraction-free editing
- ✅ **TODO Comments** - Highlight and navigate TODOs, FIXMEs, HACKs

### Version Control
- ✅ **Git Integration** - Vim-fugitive for git commands
- ✅ **Gitsigns** - Show git changes in gutter, blame inline, stage hunks

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                         # Main entry point
├── README.md                        # This file
├── lua/
│   ├── config/                     # Core configuration
│   │   ├── settings.lua            # Editor options and globals
│   │   ├── keymaps.lua             # Core leader-based keybindings
│   │   ├── keymap_extended.lua     # Extended keymaps and shortcuts
│   │   ├── lazy.lua                # Plugin manager setup & specs
│   │   ├── autocmds.lua            # Autocommands and event handlers
│   │   ├── shell.lua               # FISH shell integration
│   │   ├── mise.lua                # Mise-en-place environment
│   │   └── ui.lua                  # Advanced UI & highlight config
│   ├── plugins/                    # Plugin-specific configurations
│   │   ├── ui/
│   │   │   ├── catppuccin.lua      # Theme setup
│   │   │   └── lualine.lua         # Status line
│   │   ├── editor/
│   │   │   ├── comment.lua         # Code commenting
│   │   │   ├── autopairs.lua       # Auto bracket pairing
│   │   │   └── which-key.lua       # Keymap explorer
│   │   ├── treesitter.lua          # Syntax & text objects
│   │   ├── telescope.lua           # Fuzzy finder
│   │   ├── completion.lua          # Autocompletion
│   │   ├── snippets.lua            # Snippet management
│   │   ├── codecompanion.lua       # GitHub Copilot
│   │   ├── conform.lua             # Code formatting
│   │   ├── lint.lua                # Linting
│   │   ├── mini.lua                # Mini plugins suite
│   │   ├── trouble.lua             # Diagnostics panel
│   │   ├── todo_comments.lua       # TODO highlighting
│   │   ├── project.lua             # Project detection
│   │   ├── lsp/
│   │   │   └── mason.lua           # LSP server installer
│   │   ├── motion/
│   │   │   └── leap.lua            # Jump/motion plugin
│   │   └── git/
│   │       └── gitsigns.lua        # Git diff/blame
│   ├── lsp/
│   │   └── setup.lua               # LSP server configuration
│   └── utils/                      # Utility functions
│       ├── helpers.lua             # General helpers
│       ├── search.lua              # Search & replace
│       └── performance.lua         # Performance tools
```

## ⌨️ Comprehensive Keybindings

### Leader Key: Space

#### Window Management (`<leader>w`)
```
<leader>wh/j/k/l     Navigate windows (hjkl)
<leader>wv           Vertical split
<leader>ws           Horizontal split
<leader>wn           New window
<leader>wc           Close window
<leader>wo           Only this window
<leader>w=           Equalize window sizes
<leader>w+/-         Increase/decrease height
<leader>w>/<         Increase/decrease width
```

#### Buffer Management (`<leader>b`)
```
<leader>bn           New buffer
<leader>bd           Delete buffer
<leader>bl/h         Next/previous buffer
<leader>ba           Delete all others
```

#### File Operations (`<leader>f`)
```
<leader>ff           Find files (Telescope)
<leader>fg           Live grep
<leader>fb           Show buffers
<leader>fh           Help tags
<leader>fo           Recent files
<leader>fc           Commands
<leader>fp           Open project
<leader>fs/S         Save/save all
<leader>fe           Reload file
<leader>fq/Q         Quit/quit all
```

#### LSP Operations (`<leader>l`)
```
gd                   Goto definition
gD                   Goto declaration
gI                   Goto implementation
gr                   Show references
K                    Hover documentation
<C-k>                Signature help
<leader>la           Code actions
<leader>lr           Rename symbol
<leader>ld           Show line diagnostics
<leader>ls           Document symbols
<leader>lS           Workspace symbols
<leader>lf           Format buffer
<leader>lfm          Format with conform
<leader>ll           Run linter
[d/]d                Previous/next diagnostic
```

#### Search & Navigation (`<leader>s`)
```
<leader>sh           Clear search highlight
<leader>sw           Search word under cursor
<leader>st           Open Telescope
<leader>sr           Search & replace (project)
s/S                  Leap forward/backward
```

#### Quick Fix & Diagnostics (`<leader>x`)
```
<leader>xx/xo/xc     Toggle/open/close quickfix
<leader>xq           Show quickfix (Trouble)
<leader>xl           Show location list
<leader>xw           Buffer diagnostics
<leader>xr           References (Trouble)
<leader>xd           Definitions (Trouble)
<leader>xt           Show all TODOs
[q/]q                Previous/next quickfix
```

#### Git Operations (`<leader>g` and `<leader>gh`)
```
<leader>gh           Preview hunk
<leader>gs           Stage hunk
<leader>gu           Undo stage
<leader>gr           Reset hunk
<leader>gS           Stage buffer
<leader>gR           Reset buffer
<leader>gb           Show blame
<leader>gt           Toggle blame
<leader>gd           Diff this
[c/]c                Previous/next hunk
```

#### Debugging & Running (`<leader>d`)
```
<leader>dr           Run current file (by type)
```

#### Code Comments (`gc`, `gb`)
```
gcc                  Toggle line comment
gbc                  Toggle block comment
gc                   Toggle with motion
gb                   Toggle block with motion
gcO/gco/gcA          Comment above/below/end
```

#### Text Objects & Motions
```
<C-space>            Expand selection (TreeSitter)
af/if                Outer/inner function
ac/ic                Outer/inner class
[f/]f                Previous/next function
[c/]c                Previous/next class
```

#### Sessions & Undo (`<leader>s` and `<leader>h`)
```
<leader>ss           Save session
<leader>sr           Read session
<leader>sd           Delete session
<leader>hu           Undo
<leader>hr           Redo
```

#### UI Controls (`<leader>u`)
```
<leader>ur           Toggle relative numbers
<leader>uw           Toggle line wrap
<leader>um           Toggle minimal mode
<leader>uF           Toggle format on save
<leader>uc           Change colorscheme
```

#### Other Utilities
```
<leader>ps           Start performance profile
<leader>pp           Stop performance profile
<leader>em           Sync mise environment
<leader>m            Show all marks
<leader>yy           Yank to system clipboard
<leader>yr           Show registers
<leader>ts/tv/tt     Open terminal split/vsplit/floating
n/N                  Next/previous search (centered)
<C-u/d>              Page up/down (centered)
jj/jk                Escape insert mode
```

## 🚀 Quick Start

### Prerequisites

```bash
# Install Neovim (0.9+)
brew install neovim              # macOS
sudo apt install neovim          # Ubuntu/Debian
pacman -S neovim                 # Arch

# Install FISH shell
brew install fish                # macOS
sudo apt install fish            # Ubuntu/Debian

# Install development tools
brew install ripgrep             # Fast grep (required by Telescope)
brew install fd                  # Fast find (required by Telescope)

# Language-specific tools
npm install -g neovim            # For Node.js support
pip install pynvim               # For Python support
gem install neovim               # For Ruby support
```

### Installation

1. **Verify Config Location**
   ```bash
   ls ~/.config/nvim/
   # Should show: init.lua, lua/, README.md, etc.
   ```

2. **First Run**
   ```bash
   nvim
   # Lazy.nvim will auto-install plugins on first run
   # Mason will auto-install language servers
   ```

3. **Verify Everything Works**
   ```vim
   :checkhealth             " Run health checks
   :Mason                   " Check installed servers
   :LazyStatus              " Check plugin status
   ```

## 🔧 Configuration & Customization

### Adding Language Servers

Edit [lua/lsp/setup.lua](lua/lsp/setup.lua) and [lua/plugins/lsp/mason.lua](lua/plugins/lsp/mason.lua):

```lua
-- Add to ensure_installed list
ensure_installed = {
  "lua_ls",
  "your_new_server",  -- Add here
}

-- Add custom configuration in setup function
lspconfig.your_new_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  -- custom settings
})
```

### Creating Custom Snippets

```vim
:SnippetCreate
" Then edit ~/.config/nvim/snippets/{filetype}.json
```

### Adding More Plugins

Edit [lua/config/lazy.lua](lua/config/lazy.lua):

```lua
{
  "author/plugin-name",
  event = "VeryLazy",  -- or: keys = {}, cmd = {}, etc.
  config = function()
    require("plugins.config_name")
  end,
}
```

### Customizing Theme

Edit [lua/plugins/ui/catppuccin.lua](lua/plugins/ui/catppuccin.lua):

```lua
flavour = "latte",  -- or "frappe", "macchiato", "mocha"
```

### Custom Keybindings

Add to [lua/config/keymaps.lua](lua/config/keymaps.lua) or [lua/config/keymap_extended.lua](lua/config/keymap_extended.lua):

```lua
keymap("n", "<leader>xx", ":your_command<CR>", { desc = "Description" })
```

## 📊 Performance

Optimized for fast startup and responsive editing:

- **Lazy Loading**: Plugins load on-demand (events, commands, keys)
- **Minimal Core**: Only essential plugins on startup (~5 plugins)
- **Smart Caching**: Undo directory, persistent state
- **Optimized Settings**: Synmaxcol=200, lazyredraw, efficient diagnostics
- **Performance Tools**: Built-in profiling with `:ProfileStart` and `:ProfileStop`

**Typical startup time**: 50-100ms (measured with `:ProfileStart/:ProfileStop`)

## 🧪 Testing & Debugging

### Performance Profiling

```vim
:ProfileStart          " Start recording
" ... do some work ...
:ProfileStop           " Stop and view results
```

### Health Checks

```vim
:checkhealth           " Full health check
:checkhealth nvim_lsp  " LSP specific
:checkhealth conform   " Formatter specific
```

### LSP Debugging

```vim
:LspInfo               " Show attached servers
:LspLog                " View LSP log
```

## 📚 Documentation

### Plugin Documentation
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Neovim LSP](https://neovim.io/doc/user/lsp.html)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Mini.nvim](https://github.com/echasnovski/mini.nvim)
- [Conform](https://github.com/stevearc/conform.nvim)
- [Trouble](https://github.com/folke/trouble.nvim)

### Neovim Resources
- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://neovim.io/doc/user/lua.html)
- [Neovim API](https://neovim.io/doc/user/api.html)

## 🐛 Troubleshooting

### Plugins Not Installing

```vim
:Lazy sync
:Mason
:MasonInstall all
```

### LSP Not Working

```vim
:checkhealth nvim_lsp
:LspInfo
:Mason              " Install missing servers
```

### Performance Issues

```vim
:ProfileStart
" ... perform actions ...
:ProfileStop
```

Then check `/tmp/nvim_profile.log` for slow functions.

### Treesitter Parsing Issues

```vim
:TSUpdate
:TSInstall all
```

## 🎓 Best Practices

1. **One Config File Per Feature** - Organize plugins in separate files
2. **Lazy Load Everything** - Use `event`, `keys`, `cmd` for lazy loading
3. **Document Your Config** - Add comments explaining configuration choices
4. **Use Mnemonics** - Leader-based keybindings follow logical patterns
5. **Version Control** - Track config changes with git commits
6. **Test New Plugins** - Verify compatibility before committing

## 📝 Development Workflow

### Typical Dev Session

1. **Open Project** - `<leader>fp` to switch projects automatically
2. **Find Files** - `<leader>ff` for quick file navigation
3. **Search Code** - `<leader>fg` for project-wide grep
4. **Code with Copilot** - `<leader>cc` for AI assistance
5. **Format Code** - `<leader>lf` for auto-formatting
6. **Navigate LSP** - `gd` for definition, `gr` for references
7. **Run Linter** - `<leader>ll` for inline diagnostics
8. **Git Workflow** - `<leader>gs` to stage, `<leader>gb` to blame
9. **Commit Changes** - `:Git commit` with Fugitive

### Commit Best Practices

After feature implementation:

```bash
git add -A
git commit -m "feat: add new feature

- Detailed description of changes
- List key improvements
- Note any breaking changes"
```

## 🔗 External Integration

### Shell Integration

FISH shell is set as default. Add to `~/.config/fish/config.fish`:

```fish
# Set EDITOR to neovim
set -x EDITOR nvim
alias vi nvim
alias vim nvim
```

### Mise Integration

The config automatically loads mise environment. Verify with:

```bash
mise list
mise install  # Install tools from .mise.toml
```

## 📄 License

This configuration is provided as-is for personal and educational use. Feel free to modify, extend, and share.

---

**Happy coding!** 🚀

*Configuration maintained with step-by-step commits for easy tracking and understanding of changes.*
