-- ╔══════════════════════════════════════════════════════════════╗
-- ║         ADVANCED UI & HIGHLIGHT CONFIGURATIONS               ║
-- ║    Fine-grained control over colors and highlighting         ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Set custom highlights after colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- WINDOW SEPARATION
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight WinSeparator guifg=#45475a]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- FLOATING WINDOWS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight NormalFloat guibg=#1e1e2e]])
    vim.cmd([[highlight FloatBorder guibg=#1e1e2e guifg=#45475a]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- DIAGNOSTICS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight DiagnosticVirtualTextError guifg=#f38ba8 guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextWarn guifg=#f9e2af guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextInfo guifg=#89b4fa guibg=NONE]])
    vim.cmd([[highlight DiagnosticVirtualTextHint guifg=#94e2d5 guibg=NONE]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- SEARCH & SELECTION
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight Search guibg=#45475a guifg=#f5e0dc]])
    vim.cmd([[highlight IncSearch guibg=#f5b3a0 guifg=#1e1e2e]])
    vim.cmd([[highlight Visual guibg=#45475a guifg=NONE]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- COMPLETION MENU
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight Pmenu guibg=#313244 guifg=#cdd6f4]])
    vim.cmd([[highlight PmenuSel guibg=#45475a guifg=#cdd6f4]])
    vim.cmd([[highlight PmenuSbar guibg=#313244]])
    vim.cmd([[highlight PmenuThumb guibg=#45475a]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- SIGN COLUMN
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight SignColumn guibg=NONE]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- LINE NUMBERS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight LineNr guifg=#45475a]])
    vim.cmd([[highlight CursorLineNr guifg=#a6e3a1 guibg=#313244]])

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- FOLDING
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    vim.cmd([[highlight Folded guibg=#313244 guifg=#a6e3a1]])
    vim.cmd([[highlight FoldColumn guibg=NONE guifg=#45475a]])
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- STATUSLINE CUSTOMIZATION (works with lualine)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- The status line is configured in plugins/ui/lualine.lua
-- Additional styling can be added here if needed

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CURSOR STYLING
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
}

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MINIMAL UI MODE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Create command to toggle minimal mode
vim.api.nvim_create_user_command("MinimalMode", function(opts)
  local enable = opts.args == "on"

  vim.opt.number = not enable
  vim.opt.relativenumber = not enable
  vim.opt.signcolumn = enable and "no" or "yes:1"
  vim.opt.statusline = enable and "" or "%!luaeval('require(\"lualine\").statusline()')"

  local state = enable and "enabled" or "disabled"
  require("utils.logger").info("UI: Minimal mode " .. state)
end, {
  nargs = "?",
  complete = function()
    return { "on", "off" }
  end,
})

vim.keymap.set(
  "n",
  "<leader>um",
  "<cmd>MinimalMode on<CR>",
  { noremap = true, silent = true, desc = "UI: Toggle minimal mode" }
)
