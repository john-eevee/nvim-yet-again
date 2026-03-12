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
        component_separators = "",
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = { "diagnostics" },
        lualine_y = {},
        lualine_z = { "location" },
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
