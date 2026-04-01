return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "kanagawa",
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
