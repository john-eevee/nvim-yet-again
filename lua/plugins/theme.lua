-- Theme configuration with Catppuccin Mocha and sleek lualine
return {
  -- Catppuccin Mocha theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = true,
          telescope = true,
          which_key = true,
          dashboard = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Sleeker lualine with Catppuccin theme
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      -- Catppuccin Mocha color palette
      local colors = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
      }

      return {
        options = {
          theme = "catppuccin",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
              color = { fg = colors.crust, bg = colors.blue, gui = "bold" },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              color = { fg = colors.blue, gui = "bold" },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " 🔒",
                unnamed = "[No Name]",
              },
              color = { fg = colors.text },
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.yellow },
                removed = { fg = colors.red },
              },
              padding = { left = 1, right = 0 },
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.sky },
                hint = { fg = colors.teal },
              },
              padding = { left = 1, right = 0 },
            },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = { fg = colors.pink },
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = { fg = colors.pink },
            },
            {
              "encoding",
              padding = { left = 1, right = 0 },
              color = { fg = colors.green },
            },
            {
              "fileformat",
              symbols = {
                unix = "unix",
                dos = "dos",
                mac = "mac",
              },
              padding = { left = 1, right = 0 },
              color = { fg = colors.sky },
            },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = true,
              padding = { left = 1, right = 0 },
              color = { fg = colors.mauve },
            },
            {
              "progress",
              padding = { left = 1, right = 1 },
              color = { fg = colors.subtext0 },
            },
          },
          lualine_z = {
            {
              "location",
              color = { fg = colors.crust, bg = colors.pink, gui = "bold" },
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
              color = { fg = colors.surface2 },
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
  },

  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
