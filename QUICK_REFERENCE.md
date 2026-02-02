# Quick Reference Card

## Installation

After restarting Neovim, all tools will install automatically via Mason. To verify:

```vim
:Mason                    " Open package manager
:checkhealth             " Check overall health
```

## Themes & Appearance

✨ **Catppuccin Mocha** theme with:
- Sleek, minimal lualine statusbar
- Beautiful Catppuccin colors throughout
- Custom LSP diagnostic colors
- Smooth visual experience

## Language Support

| Language | Server | Formatter | Features |
|----------|--------|-----------|----------|
| **Elixir** | ElixirLS | elixirformat | Tests, Specs, Type checking |
| **Dart** | DartLS | dartfmt | Color picker, Hot reload |
| **Flutter** | flutter-tools | dartfmt | Run, Debug, Device select |

## Key Bindings

### Global LSP
```
gd       Go to definition
gr       Find references
K        Hover docs
<leader>ca    Code actions
<leader>cR    Rename
<leader>cf    Format
```

### Snippets
```
<Tab>     Next placeholder
<S-Tab>   Previous placeholder
<C-l>     Expand/jump forward
<C-h>     Jump backward
```

### Flutter
```
<leader>fa    Run app
<leader>fq    Quit
<leader>fr    Reload (hot)
<leader>fR    Restart (hot)
<leader>fD    Select device
```

## Commands

```vim
:Mason                    Open package manager
:LspInfo                  Check LSP servers
:LspRestart              Restart LSP
:checkhealth mason        Check Mason status
:checkhealth lsp          Check LSP health
:Telescope lsp_references Find references
:Telescope diagnostics    List diagnostics
```

## File Types

- `.ex` → Elixir source
- `.exs` → Elixir scripts
- `.eex` → Embedded Elixir (Phoenix)
- `.dart` → Dart source
- `.lua` → Lua scripts

## Common Tasks

### Debug a Flutter App
1. Open `.dart` file
2. `:DapToggleBreakpoint` to set breakpoints
3. `:DapContinue` to start debugging
4. Use `n` (next), `s` (step), `c` (continue)

### Format Entire Project
```vim
:%!elixirformat      " Elixir
:%!dartfmt           " Dart
```

### Insert Snippet
Start typing snippet keyword, press `<Tab>` to expand

### Jump Between Errors
```vim
]d    Next diagnostic
[d    Previous diagnostic
```

## Settings Files

All settings are in `lua/plugins/`:
- `theme.lua` - Colors and UI
- `lang-elixir.lua` - Elixir config
- `lang-dart.lua` - Dart/Flutter config
- `snippets.lua` - Snippet settings

## Performance Tips

1. Use `:Mason` to keep tools updated
2. Enable `--dialyzer` for Elixir type checking
3. Use `:LspStop` when not coding to save resources
4. Restart LSP if it becomes unresponsive

## Getting Help

```vim
:help lspconfig         LSP configuration
:help luasnip           Snippets documentation
:help catppuccin        Theme options
:help flutter-tools     Flutter plugin docs
```

## Session Commands

```vim
:mksession! ~/.session.vim    Save session
:source ~/.session.vim        Load session
```

## Useful Plugins Already Included

- telescope - Fuzzy finder
- nvim-tree - File explorer
- treesitter - Syntax highlighting
- lualine - Statusbar
- which-key - Keybinding hints
- mason - Package manager
- conform - Formatting
- cmp - Autocompletion
- dap - Debugger

Happy coding! 🚀
