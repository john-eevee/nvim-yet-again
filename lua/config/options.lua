vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add mise shims to PATH (overrides system tools with mise-managed versions)
local mise_shims = vim.fn.expand("~/.local/share/mise/shims")
if vim.fn.isdirectory(mise_shims) == 1 then
  vim.env.PATH = mise_shims .. ":" .. vim.env.PATH
end

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true

-- Tabs & indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.signcolumn = "yes:1"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.breakindent = true
vim.opt.laststatus = 3

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.synmaxcol = 200

-- Project-local config (.nvim.lua / .nvimrc / .exrc)
-- Nvim reads these from the current directory and every parent directory, but
-- only executes files that are in the trust list: an unknown file prompts first
-- and the answer is persisted (see :trust). Unset 'exrc' in a project config to
-- stop the upward search there.
vim.opt.exrc = true

-- Files & buffers
vim.opt.hidden = true
vim.opt.modeline = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.opt.writebackup = false
vim.opt.confirm = true
vim.opt.fileencoding = "utf-8"

-- Formatting
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Fillchars
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  diff = "╱",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}
