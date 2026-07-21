# nvim config — minimal & focused

A clean Neovim configuration built for an IntelliJ-style workflow.

## Keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<Space>ff` | Find files |
| `<Space>fr` | Recent files |
| `<Space>fg` | Live grep |
| `<Space>fb` | Open buffers |
| `<Space>e` | File explorer (Oil) |
| `<Space>n` | New file |
| `<Space>bd` | Close buffer |
| `<Space>bD` | Close other buffers |
| `<Space>bA` | Close all buffers |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code action |
| `<Space>f` | Format buffer |
| `<Space>sr` | Search & replace |
| `<Space>db` | Toggle DB UI |
| `<C-Tab>` / `<A-l>` | Next buffer |
| `<C-S-Tab>` / `<A-h>` | Previous buffer |
| `g;` | Previous change location |
| `g,` | Next change location |
| `jk` / `jj` | Exit insert mode |
| `s` | Flash jump (navigation) |

## Structure

```
~/.config/nvim/
├── init.lua               # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua    # Neovim options
│   │   ├── keymaps.lua    # Keybindings
│   │   ├── autocmds.lua   # Autocommands
│   │   └── lazy.lua       # Plugin manager
│   └── plugins/
│       ├── 01-core.lua    # Colorscheme, treesitter, which-key, mini
│       ├── 02-editor.lua  # Telescope, oil, conform, gitsigns, flash, etc.
│       ├── 03-lsp.lua     # LSP, mason, blink.cmp, luasnip
│       └── 04-lang-sql.lua # Dadbod suite
└── lazy-lock.json         # Plugin lockfile
```
