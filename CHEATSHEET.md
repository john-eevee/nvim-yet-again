-- ╔══════════════════════════════════════════════════════════════╗
-- ║          QUICK REFERENCE GUIDE FOR NEOVIM CONFIG              ║
-- ║    Copy this to reference while editing without leaving vim  ║
-- ╚══════════════════════════════════════════════════════════════╝

/*
 * MOST USED KEYBINDINGS
 */

-- Files & Buffers
<leader>ff   Find files
<leader>fg   Live grep (search)
<leader>fb   Show buffers
<leader>bn   New buffer
<leader>bd   Delete buffer

-- Navigation
s/S          Leap forward/backward (like AceJump)
gd           Go to definition
gr           Show references
<leader>fp   Open project

-- Git
<leader>gs   Stage hunk
<leader>gb   Show blame
<leader>gd   Show diff

-- Code
<leader>la   Code actions
<leader>lr   Rename
<leader>lf   Format
<leader>ll   Lint

-- Copilot AI
<leader>cc   Open Copilot chat
<leader>ca   Code actions

-- Windows
<leader>wv   Split vertical
<leader>ws   Split horizontal
<leader>wh   Move left

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// PLUGINS INCLUDED
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

UI & Theme:
  - catppuccin: Beautiful color theme (mocha)
  - lualine: Status line with git and diagnostics
  - which-key: Show available keybindings

Code Editing:
  - nvim-cmp: Smart autocompletion
  - LuaSnip: Code snippets
  - nvim-autopairs: Auto bracket pairing
  - mini.nvim: Surround, text objects, align, move lines
  - comment.nvim: Smart code commenting (gc/gb)
  - conform.nvim: Auto formatting on save

Language & LSP:
  - nvim-lspconfig: Language server protocol setup
  - mason: Auto-install language servers
  - nvim-lint: Async linting
  - treesitter: Better syntax highlighting & text objects

Search & Navigation:
  - telescope: Fuzzy finder for files, grep, symbols
  - leap.nvim: AceJump-style jumping
  - project.nvim: Project detection
  - trouble.nvim: Pretty diagnostics list
  - todo-comments: Highlight and find TODOs

Git:
  - vim-fugitive: Git commands
  - gitsigns: Show git diff, blame, stage hunks

AI:
  - codecompanion: GitHub Copilot integration

Utilities:
  - nvim-notify: Beautiful notifications
  - vim-surround: Change surrounding characters (ys/ds/cs)

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// LANGUAGE SERVER SUPPORT
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Automatic: Python, Rust, Go, C/C++, TypeScript, JavaScript, HTML, CSS,
          JSON, YAML, Lua, Markdown, ESLint, Black

Auto-installed on first run via Mason.

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// COMMAND CHEATSHEET
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

:Mason                  Install/manage language servers
:checkhealth            Run health checks
:ProfileStart           Start performance profiling
:ProfileStop            Stop and view profile results
:SnippetCreate          Create new code snippet
:MiseSync               Sync mise environment
:MinimalMode on/off     Toggle minimal UI mode
:Telescope <cmd>        Open telescope picker
:Trouble                Show diagnostics
:TodoTelescope          Show all TODO comments

:LazySync               Install/update plugins
:LazyStatus             Show plugin status

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// TYPICAL WORKFLOW
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Open project:      <leader>fp
2. Find files:        <leader>ff
3. Search code:       <leader>fg
4. Jump to def:       gd
5. View references:   gr
6. AI suggestion:     <leader>cc
7. Format code:       <leader>lf
8. Stage changes:     <leader>gs
9. View git blame:    <leader>gb
10. Commit:           :Git commit

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// TIPS & TRICKS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Use 's' to jump to a specific character (like AceJump)
• Press <leader>? to see all available keybindings
• [d and ]d navigate between diagnostics
• <C-u>/<C-d> scroll half page (keeps cursor centered)
• jj or jk exits insert mode quickly
• <leader>ur toggles relative line numbers
• <leader>uw toggles line wrapping
• Use <Tab>/<S-Tab> in completions to navigate
• vim-surround: ys<motion><char> to add surrounding chars
• mini.move: <M-hjkl> to move lines/blocks

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// TROUBLESHOOTING
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Plugins not loading?       :Lazy sync
Copilot not working?       :checkhealth codecompanion
LSP issues?                :LspInfo
Slow performance?          :ProfileStart ... :ProfileStop
No language servers?       :Mason :MasonInstall all
Treesitter issues?         :TSUpdate
