# Elixir Support for LazyVim

This configuration adds comprehensive Elixir/Phoenix development support to your LazyVim setup.

## What's Included

### 1. **Treesitter Parsers**
   - `elixir` - Elixir language syntax highlighting
   - `eex` - Embedded Elixir template support (for `.eex` files)

### 2. **Language Server (LSP)**
   - **ElixirLS** - Provides:
     - Code completion
     - Go to definition
     - Hover information
     - Diagnostics (via Dialyzer)
     - Document formatting
     - Test lenses (run tests inline)
     - Spec suggestions

### 3. **Formatting**
   - **elixirformat** - Automatic code formatting via Mason

### 4. **Debugging** (Optional)
   - **nvim-dap** integration for Elixir debugging
   - Supports Phoenix projects with `phx.server` debugging

## Installation

The plugin will automatically:
1. Install ElixirLS and elixirformat via Mason
2. Download and compile Treesitter parsers
3. Configure the language server

When you open your first `.ex` or `.exs` file, LazyVim will:
- Prompt to install the language server (if not installed)
- Enable syntax highlighting
- Activate LSP features

## Usage

### Common LSP Commands
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover information
- `<leader>ca` - Code actions
- `<leader>cR` - Rename symbol

### Formatting
- Format current file: `:Neoformat` or `<leader>cf`
- Format on save: Enabled by default in LazyVim

### Debugging (if enabled)
- Set breakpoints: `:DapToggleBreakpoint`
- Start debugger: `:DapContinue`
- Step through code: `:DapStepOver`, `:DapStepInto`

## Configuration

You can customize ElixirLS settings by editing `lua/plugins/lang-elixir.lua`:

```lua
elixirls = {
  settings = {
    elixirLS = {
      dialyzerEnabled = true,        -- Enable type checking
      fetchDeps = false,              -- Auto-fetch dependencies
      enableTestLenses = true,        -- Show test runners inline
      suggestSpecs = true,            -- Suggest function specs
    },
  },
},
```

## Troubleshooting

### ElixirLS not found
```bash
# Manually install via Mason
:Mason
# Search for "elixir-ls" and install
```

### Language server not activating
- Make sure you're in a valid Elixir project directory
- Check `:LspInfo` to see if the server is attached
- Restart Neovim: `:e!` or restart the LSP `:LspRestart`

### Formatting not working
- Install elixirformat: `:MasonInstall elixirformat`
- Set your formatter in `lua/config/options.lua`

## Files Modified

- Created: `lua/plugins/lang-elixir.lua` - Main Elixir support configuration

## Next Steps

1. Restart Neovim
2. Open an `.ex` or `.exs` file
3. Run `:Mason` to verify tools are installed
4. Enjoy Elixir development! 🚀
