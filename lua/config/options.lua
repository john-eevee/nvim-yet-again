-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for navigation
vim.opt.cursorline = true -- Highlight current line
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- 2 spaces per tab
vim.opt.shiftwidth = 2 -- Indentation width
vim.opt.softtabstop = 2 -- Soft tab width
vim.opt.autoindent = true -- Preserve indentation
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = false -- No word wrap
vim.opt.scrolloff = 8 -- Vertical scroll offset
vim.opt.sidescrolloff = 16 -- Horizontal scroll offset
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase present
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus"
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PERFORMANCE OPTIMIZATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.updatetime = 250 -- Faster response for plugins
vim.opt.timeoutlen = 300 -- Leader key timeout
vim.opt.ttimeoutlen = 50 -- Terminal codes timeout
vim.opt.synmaxcol = 200 -- Limit syntax highlighting span
vim.opt.termguicolors = true -- True color support

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DISPLAY & UI
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.showmode = false -- Don't show mode (shown in statusline)
vim.opt.showcmd = false -- Don't show partial commands
vim.opt.cmdheight = 0 -- Hide command bar when inactive
vim.opt.pumheight = 8 -- Completion menu height
vim.opt.pumwidth = 20 -- Completion menu width
vim.opt.signcolumn = "yes:1" -- Always show sign column (gutter)
vim.opt.foldcolumn = "0" -- Hide fold column
vim.opt.splitbelow = true -- Splits go below
vim.opt.splitright = true -- Splits go right (important for layout)
vim.opt.breakindent = true -- Wrapped lines indent
vim.opt.laststatus = 3 -- Global statusline
vim.opt.fillchars = {
  eob = " ", -- Hide end of buffer
  fold = " ", -- Hide fold
  diff = "╱", -- Better diff character
  vert = " ", -- Transparent vertical split
  horiz = " ", -- Transparent horizontal split
  msgsep = " ", -- Transparent message separator
}
vim.opt.winblend = 0 -- Disable pseudo-transparency in favor of real
vim.opt.pumblend = 0 -- Popup transparency

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- FILE & BUFFER HANDLING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.hidden = true -- Allow unsaved buffers in background
vim.opt.modeline = false -- Disable modeline for security
vim.opt.backup = false -- No backup files
vim.opt.swapfile = false -- No swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo") -- Undo directory
vim.opt.writebackup = false -- No backup on write
vim.opt.confirm = true -- Confirm before discarding changes
vim.opt.fileencoding = "utf-8" -- UTF-8 encoding

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SEARCH & REPLACE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Incremental search
vim.opt.gdefault = false -- Don't use 'g' flag by default in substitutions

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CODE FORMATTING & COMPLETION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.opt.formatoptions:remove("c") -- Don't auto-comment on new line
vim.opt.formatoptions:remove("r") -- Don't auto-comment on new line
vim.opt.formatoptions:remove("o") -- Don't auto-comment on new line
vim.g.format_on_save = false -- Disable format on save by default (enable per project)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- GLOBALS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.hl.priorities.treesitter = 210
