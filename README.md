# nvim config — minimal & focused

A clean Neovim configuration built for an IntelliJ-style workflow.

## Keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<Space>ff` | Find anything (switch source in-picker: `<C-g>` grep, `<C-b>` buffers, `<C-o>` recent, `<C-h>` help, `<C-r>` resume) |
| `<Space>fg` | Find anything, starting in live grep |
| `<Space>fr` | Recent files |
| `<Space>fb` | Open buffers |
| `<Space>e` | File explorer (Oil) |
| `<Space>n` | New file |
| `<Space>bb` | Most recently used buffer |
| `<Space>bd` | Close buffer |
| `<Space>bD` | Close other buffers |
| `<Space>bA` | Close all buffers |
| `<Space>rn` | Rename symbol |
| `<Space>ca` / `<A-CR>` | Code action |
| `<Space>f` | Format buffer |
| `<Space>sr` | Search & replace |
| `<Space>db` | Toggle DB UI |
| `<Space>on` | New note (Obsidian) |
| `<Space>ot` | Today's daily note |
| `<Space>oq` | Quick switch note |
| `<Space>os` | Search notes |
| `<Space>ob` / `<Space>ol` | Note backlinks / links (inside a note) |
| `<Space>oo` | Open note in the Obsidian app |
| `<Space>tp` / `<Space>ts` | Typst: toggle live preview / sync preview to cursor |
| `<CR>` (in notes) | Smart action: follow link, toggle checkbox, show tag |
| `[o` / `]o` (in notes) | Jump to previous / next link |
| `<Space>q` | Quickfix list |
| `<Space>gs` / `<Space>gr` / `<Space>gb` / `<Space>gp` | Stage / reset / blame / preview hunk |
| `<C-Tab>` / `<A-l>` / `]b` | Next buffer |
| `<C-S-Tab>` / `<A-h>` / `[b` | Previous buffer |
| `]h` / `[h` | Next / previous git hunk |
| `]q` / `[q` | Next / previous quickfix entry |
| `]t` / `[t` | Next / previous TODO comment |
| `g;` / `g,` | Previous / next change location |
| `K` | Hover docs |
| `gd` / `gD` / `gi` / `gr` | Definition / declaration / implementation / references |
| `jk` / `jj` / `jw` | Exit insert mode / exit insert mode and save |
| `af` / `if` / `ac` / `ic` | Textobjects: function/class, outer/inner |
| `]f` `]c` `]F` `]C` / `[f` `[c` `[F` `[C` | Next / previous function or class, start or end |
| `an` / `in` | Select parent / child node (Nvim's built-in, treesitter + LSP) |
| `]n` `]N` / `[n` `[N` | Grow selection to next / previous node or sibling |
| `s` / `S` | Flash jump / flash treesitter |
| `<Esc>` | Clear search highlights |
| `n` / `N` / `<C-u>` / `<C-d>` | Centered navigation |
| `:ExtractToFile` | Cut the visual selection and append it to another file |

Command abbreviations are also set up: `W`, `Wq`, `Q`, `Qa`, `WQ`, `QA`, `q1`, `w1`.

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (+ native vim.lsp config for Elixir)
├── lua/
│   ├── config/
│   │   ├── options.lua         # Neovim options
│   │   ├── keymaps.lua         # Keybindings
│   │   ├── autocmds.lua        # Autocommands
│   │   ├── find-anything.lua   # Unified telescope picker
│   │   ├── extract-to-file.lua # :ExtractToFile command
│   │   └── lazy.lua            # Plugin manager
│   └── plugins/
│       ├── 01-core.lua         # Colorscheme, treesitter, which-key, mini
│       ├── 02-editor.lua       # Telescope, oil, conform, gitsigns, flash, etc.
│       ├── 03-lsp.lua          # LSP, mason, blink.cmp, luasnip
│       ├── 04-lang-sql.lua     # Dadbod suite
│       ├── 05-lang-rust.lua    # rust-analyzer (mise), crates.nvim
│       ├── 06-lang-dart.lua    # flutter-tools
│       ├── 07-lang-java.lua    # nvim-java
│       ├── 08-lang-elixir.lua  # Elixir treesitter parsers
│       ├── 09-lang-svelte.lua  # svelte-language-server (mise/npx)
│       ├── 10-notes.lua        # Obsidian vault (obsidian.nvim)
│       └── 11-lang-typst.lua   # tinymist (Typst LSP) + typst-preview.nvim
├── bin/
│   └── tinymist-preview-shim   # drops tinymist's deprecated --static-file-host
├── docs/
│   └── VIM_MOTIONS_CHEATSHEET.md
└── lazy-lock.json              # Plugin lockfile
```
