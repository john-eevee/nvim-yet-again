return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        always_divide_middle = false,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1):upper()
            end,
            color = function()
              local mode_color = {
                n = { fg = "#1e1e2e", bg = "#cdd6f4" }, -- normal
                i = { fg = "#1e1e2e", bg = "#a6e3a1" }, -- insert
                v = { fg = "#1e1e2e", bg = "#f38ba8" }, -- visual
                V = { fg = "#1e1e2e", bg = "#f38ba8" }, -- visual line
                c = { fg = "#1e1e2e", bg = "#f9e2af" }, -- command
                R = { fg = "#1e1e2e", bg = "#fab387" }, -- replace
                t = { fg = "#1e1e2e", bg = "#94e2d5" }, -- terminal
              }
              local current_mode = vim.fn.mode():sub(1, 1)
              return mode_color[current_mode] or { fg = "#1e1e2e", bg = "#cdd6f4" }
            end,
          },
        },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics" },
        lualine_y = {},
        lualine_z = { "lsp_status", "location" },
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
      extensions = {},
    })
  end,
}
