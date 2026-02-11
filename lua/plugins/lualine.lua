return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "shaunsingh/nord.nvim",
  },
  event = "VeryLazy",
  opts = function()
    local configuration = vim.fn["everforest#get_configuration"]()
    local palette = vim.fn["everforest#get_palette"](configuration.background, configuration.colors_override)

    if configuration.transparent_background == 2 then
      palette.bg1 = palette.none
    end

    palette = {
      normal = {
        a = { bg = palette.statusline1[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.grey2[1] },
        c = { bg = palette.bg1[1], fg = palette.grey1[1] },
      },
      insert = {
        a = { bg = palette.statusline2[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.fg[1] },
        c = { bg = palette.bg1[1], fg = palette.fg[1] },
      },
      visual = {
        a = { bg = palette.statusline3[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.fg[1] },
        c = { bg = palette.bg1[1], fg = palette.fg[1] },
      },
      replace = {
        a = { bg = palette.orange[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.fg[1] },
        c = { bg = palette.bg1[1], fg = palette.fg[1] },
      },
      command = {
        a = { bg = palette.aqua[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.fg[1] },
        c = { bg = palette.bg1[1], fg = palette.fg[1] },
      },
      terminal = {
        a = { bg = palette.purple[1], fg = palette.bg0[1], gui = "bold" },
        b = { bg = palette.bg3[1], fg = palette.fg[1] },
        c = { bg = palette.bg1[1], fg = palette.fg[1] },
      },
      inactive = {
        a = { bg = palette.bg1[1], fg = palette.grey1[1] },
        b = { bg = palette.bg1[1], fg = palette.grey1[1] },
        c = { bg = palette.bg1[1], fg = palette.grey1[1] },
      },
    }
    -- Load the configured theme and make section backgrounds transparent
    -- while moving the previous background color to the foreground.

    -- For each mode and each section (a,b,c) set bg to 'NONE' and
    -- set fg to the previous bg so the foreground becomes the old background.
    local theme = palette
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
        theme = theme,
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
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
        lualine_b = {
          {
            "branch",
            icon = "",
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ",
              readonly = " ",
              unnamed = "",
            },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            diff_color = {},
            padding = { left = 1, right = 0 },
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
            padding = { left = 1, right = 0 },
          },
        },
        lualine_x = {
          {
            "encoding",
            padding = { left = 1, right = 0 },
          },
          -- {
          -- "fileformat",
          -- symbols = {
          --   unix = "unix",
          --   dos = "dos",
          --   mac = "mac",
          -- },
          -- padding = { left = 1, right = 0 },
          --  },
        },
        lualine_y = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          {
            "progress",
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            "location",
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            color = {},
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy", "trouble", "mason", "quickfix" },
    }
  end,
}
