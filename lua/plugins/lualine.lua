return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "shaunsingh/nord.nvim",
  },
  event = "VeryLazy",
  opts = function()
    local theme = "rose-pine"
    return {
      options = {
        theme = theme,
        component_separators = "",
        -- searches nf-ple
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "󰘬" } },
        lualine_c = {},
        lualine_x = { "diagnostics" },
        lualine_y = { "lsp_status" },
        lualine_z = {},
      },
      tabline = {
        lualine_a = { "buffers" },
        lualine_b = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
    }
  end,
}
