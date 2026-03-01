return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "shaunsingh/nord.nvim",
  },
  event = "VeryLazy",
  opts = function()
    -- Load the configured theme and make section backgrounds transparent
    -- while moving the previous background color to the foreground.

    -- For each mode and each section (a,b,c) set bg to 'NONE' and
    -- set fg to the previous bg so the foreground becomes the old background.
    local theme = "catppuccin"
    -- local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
    -- for _, mode in ipairs(modes) do
    --   local m = theme[mode]
    --   if type(m) == "table" then
    --     for _, sec in ipairs({ "a", "b", "c" }) do
    --       local s = m[sec]
    --       if type(s) == "table" then
    --         if s.bg then
    --           -- s.fg = s.bg
    --         end
    --         s.bg = "NONE"
    --       end
    --     end
    --   end
    -- end
    --
    return {
      options = {
        theme = "catppuccin",
        component_separators = "",
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          "%=",
          {
            "filename",
            path = 0,
          },
        },
        lualine_x = { "diagnostics" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    }
  end,
}
