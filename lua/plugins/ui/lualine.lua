-- ╔══════════════════════════════════════════════════════════════╗
-- ║          LUALINE - MINIMAL STATUS LINE                       ║
-- ║    Clean, lightweight status line with essential info         ║
-- ╚══════════════════════════════════════════════════════════════╝

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha" },
      winbar = {},
    },
    ignore_focus = { "TelescopePrompt", "TelescopeResults" },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = " ●",
          readonly = " 🔒",
          unnamed = "[No Name]",
        },
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_lsp", "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "fugitive", "telescope" },
})
