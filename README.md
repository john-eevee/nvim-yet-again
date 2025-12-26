# Neovim Configuration — Compact Quick Start

A compact, terminal-centric Neovim configuration optimized for speed, LSP, and AI assistance.

Highlights
- Space as leader key, FISH-friendly, lazy-loaded plugins for fast startup
- LSP support (Python, Rust, Go, C/C++, TS/JS, HTML/CSS, JSON, YAML, Lua, Markdown)
- TreeSitter, Telescope, Conform (formatting), Nvim-lint (linting)
- CodeCompanion (Copilot), Git integration (Fugitive, Gitsigns), and useful UI plugins

Quick Install
1. Clone this repo to `~/.config/nvim` and open Neovim:

   git clone <repo> ~/.config/nvim
   nvim

2. On first run Lazy.nvim will install plugins and Mason will offer LSP installs.
3. Run `:checkhealth` to verify setup.

Required System Binaries & Tools
- Shell: fish (recommended)
- Core CLI: git, curl, unzip, fd, ripgrep

Clipboard utilities (for copy/paste features):
- Linux: `wl-clipboard` (wl-copy) or `xclip`
- macOS: `pbcopy`

Extras (recommended):
- mise
- lld or clang-format for C/C++ formatting (optional)

Usage & Key Shortcuts
- Browse keymaps: `<leader>km` or `:Keymaps`

Testing & Validation

Validate configuration integrity:

```bash
# Run comprehensive test suite (69 tests)
cd ~/.config/nvim && tests/run_tests.sh
```

Tests check:
- File structure and syntax
- Required system tools (git, fish, curl)
- Optional language runtimes (Java, Python, Go, Rust, etc.)
- LSP setup and Java configuration
- Clipboard utilities availability
- Neovim version compatibility (≥0.9)

See [tests/QUICK_START.md](tests/QUICK_START.md) for detailed testing guide.


Customizing
- Add plugins in `lua/config/lazy.lua`
- Change keymaps in `lua/config/keymaps.lua`
- Update LSP servers in `lua/lsp/java.lua` and `lua/plugins/lsp/mason.lua`

Troubleshooting
- `:checkhealth` for diagnostics
- `:Lazy sync` to reinstall plugins
- `:Mason` to manage LSP servers

