# LazyVim Enhanced Setup Guide

This configuration includes comprehensive support for multiple languages and a beautiful theming setup.

## 🎨 Theme & UI

### Catppuccin Mocha Theme
Beautiful dark theme with warm, muted colors that's easy on the eyes.

- **Status Bar**: Custom sleek lualine with Catppuccin colors
- **Integrations**: Full support for Mason, Telescope, Treesitter, LSP, and more
- **Features**: Dim inactive windows, italic comments, smooth visual experience

**Colors**: Mocha flavor includes pastels like lavender (`#89b4fa`), pink (`#f38ba8`), and green (`#a6e3a1`)

## 📝 Snippets (LuaSnip)

Powerful snippet engine with community-contributed snippets.

### Features
- **Smart Tab Navigation**: Use `<Tab>` and `<S-Tab>` to navigate snippet placeholders
- **Jump in/out**: `<C-l>` to expand/jump forward, `<C-h>` to jump backward
- **Auto-snippets**: Automatically triggered based on context
- **Community Snippets**: 500+ snippets via friendly-snippets

### Usage
```lua
-- In insert mode
<Tab>           -- Jump to next placeholder or next snippet
<S-Tab>         -- Jump to previous placeholder
<C-l>           -- Expand snippet or jump to next choice
<C-h>           -- Jump to previous choice
```

### Adding Custom Snippets
Create files in `~/.config/nvim/snippets/` or in package-specific directories.

## 🎯 Elixir Development

### Features
- **ElixirLS**: Full language server with code completion, diagnostics, and formatting
- **Treesitter**: Syntax highlighting for Elixir and EEx templates
- **Formatters**: elixirformat for code formatting
- **Dialyzer**: Type checking and analysis

### Server Features
- Code completion
- Go to definition / Find references
- Type checking via Dialyzer
- Test lenses (run tests inline)
- Function spec suggestions

### Files
- `.ex` - Elixir source files
- `.exs` - Elixir scripts
- `.eex` - Embedded Elixir templates

## 🚀 Dart & Flutter Development

### Features
- **DartLS**: Complete language server with intelligent code completion
- **flutter-tools**: Dedicated Flutter plugin with commands
- **Debugger**: nvim-dap integration for breakpoints and stepping
- **Formatting**: dartfmt for automatic code formatting

### Flutter Commands
```vim
<leader>fa   -- Run Flutter app
<leader>fq   -- Quit Flutter
<leader>fr   -- Reload (hot reload)
<leader>fR   -- Restart (hot restart)
<leader>fD   -- Select device
```

### Features
- Widget outline and navigation
- Closing tags highlighting
- Color picker integration
- Hot reload / Hot restart support
- Device selection and testing

### Configuration
See `lua/plugins/lang-dart.lua` for customization options:
- Line length (default: 80)
- Devtools port (default: 9100)
- Widget guides and closing tags

## 🛠️ Mason Package Manager

Automatic installation of language servers, formatters, and debuggers.

### Installed Tools
- **Elixir**: elixir-ls, elixirformat
- **Dart**: dart-debug-adapter, dartfmt, flutter
- **Snippets**: LuaSnip, friendly-snippets

### Manual Installation
```vim
:Mason                    -- Open Mason UI
:MasonInstall <package>   -- Install a tool
:MasonUpdate              -- Update all tools
```

## ⌨️ Key Mappings

### LSP Mappings (All Languages)
```vim
gd        -- Go to definition
gr        -- Find references
K         -- Hover information
<leader>ca -- Code actions
<leader>cR -- Rename symbol
<leader>cf -- Format file
```

### Snippet Mappings
```vim
<Tab>     -- Next placeholder
<S-Tab>   -- Previous placeholder
<C-l>     -- Expand/jump
<C-h>     -- Jump back
```

### Flutter Mappings
```vim
<leader>fa -- Run
<leader>fq -- Quit
<leader>fr -- Reload
<leader>fR -- Restart
<leader>fD -- Devices
```

## 🎯 Treesitter Languages

Syntax highlighting and code navigation:
- Elixir, EEx
- Dart
- Python, JavaScript, TypeScript, TSX
- Lua, Bash, JSON, YAML
- Markdown and more

## 🐛 Troubleshooting

### Mason Tools Not Installing
1. Check Mason status: `:checkhealth mason`
2. Open Mason: `:Mason`
3. Try installing manually
4. Check system dependencies (Dart SDK, Elixir, etc.)

### Language Server Not Activating
```vim
:LspInfo                 -- Check active servers
:LspRestart              -- Restart language servers
:LspLog                  -- View LSP logs
```

### Snippets Not Working
```vim
:lua require("luasnip.loaders.from_vscode").lazy_load()
```

### Theme Issues
If colors look wrong, try:
```vim
:colorscheme catppuccin
:set termguicolors
```

## 📦 Plugin Files

- **`lua/plugins/theme.lua`** - Catppuccin Mocha + sleek lualine
- **`lua/plugins/lang-elixir.lua`** - Elixir support
- **`lua/plugins/lang-dart.lua`** - Dart & Flutter support
- **`lua/plugins/snippets.lua`** - LuaSnip & friendly-snippets

## 🔧 Configuration

### Customize Lualine
Edit `lua/plugins/theme.lua` to change statusbar appearance, colors, or sections.

### Customize Catppuccin
Modify the setup in `lua/plugins/theme.lua` to enable/disable integrations.

### Add More Languages
Create `lua/plugins/lang-<language>.lua` following the existing patterns.

## 📚 Resources

- [Catppuccin](https://catppuccin.com/) - Theme documentation
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim) - Flutter plugin
- [ElixirLS](https://github.com/elixir-lsp/elixir-ls) - Language server
- [DartLS](https://github.com/dart-lang/sdk/tree/main/pkg/analysis_server) - Language server

## ✨ Next Steps

1. Restart Neovim
2. Run `:Mason` to verify tools are installed
3. Open your first Elixir, Dart, or Flutter file
4. Start coding with full IDE support!

Happy coding! 🚀
