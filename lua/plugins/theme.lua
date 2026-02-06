-- Theme configuration with Rosé Pine and sleek lualine
return {
  -- Rosé Pine theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- main, moon, or dawn
        dark_variant = "main",
        dim_inactive = true,
        dim_nc_background = false,
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
        groups = {
          background = "base",
          background_nc = "base",
          panel = "surface",
          panel_nc = "base",
          border = "highlight_med",
          comment = "muted",
          link = "iris",
          punctuation = "subtle",

          error = "love",
          hint = "iris",
          info = "foam",
          ok = "pine",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },
        },
        palette = {
          base = "#191724",
          surface = "#1f1d2e",
          overlay = "#26233c",
          muted = "#6e6a86",
          subtle = "#908caa",
          text = "#e0def4",
          love = "#eb6f92",
          gold = "#f6c177",
          rose = "#ebbcba",
          pine = "#31748f",
          foam = "#9ccfd8",
          iris = "#c4a7e7",
          hl_low = "#21202e",
          hl_med = "#403d52",
          hl_high = "#524f67",
        },
        highlight_groups = {
          ColorColumn = { bg = "surface" },
          CursorLine = { bg = "hl_low" },
          CursorLineNr = { bold = true },
          LineNr = { fg = "muted" },
          Visual = { bg = "overlay", bold = true },
          VisualNOS = { bg = "overlay", bold = true },
          Search = { bg = "overlay", bold = true },
          IncSearch = { bg = "love", fg = "base", bold = true },
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },

  -- Sleeker lualine with Rosé Pine theme
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- Rosé Pine color palette
      local colors = {
        base = "#191724",
        surface = "#1f1d2e",
        overlay = "#26233c",
        muted = "#6e6a86",
        subtle = "#908caa",
        text = "#e0def4",
        love = "#eb6f92",
        gold = "#f6c177",
        rose = "#ebbcba",
        pine = "#31748f",
        foam = "#9ccfd8",
        iris = "#c4a7e7",
      }

      return {
        options = {
          theme = "rose-pine",
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
              color = { fg = colors.base, bg = colors.iris, gui = "bold" },
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
              color = { fg = colors.iris, gui = "bold" },
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
                added = "+",
                modified = "~",
                removed = "-",
              },
              diff_color = {
                added = { fg = colors.foam },
                modified = { fg = colors.gold },
                removed = { fg = colors.love },
              },
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
              diagnostics_color = {
                error = { fg = colors.love },
                warn = { fg = colors.gold },
                info = { fg = colors.foam },
                hint = { fg = colors.iris },
              },
              padding = { left = 1, right = 0 },
            },
          },
          lualine_x = {
            {
              "encoding",
              padding = { left = 1, right = 0 },
              color = { fg = colors.foam },
            },
            {
              "fileformat",
              symbols = {
                unix = "unix",
                dos = "dos",
                mac = "mac",
              },
              padding = { left = 1, right = 0 },
              color = { fg = colors.pine },
            },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = true,
              padding = { left = 1, right = 0 },
              color = { fg = colors.iris },
            },
            {
              "progress",
              padding = { left = 1, right = 1 },
              color = { fg = colors.subtle },
            },
          },
          lualine_z = {
            {
              "location",
              color = { fg = colors.base, bg = colors.rose, gui = "bold" },
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
              color = { fg = colors.overlay },
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
}
