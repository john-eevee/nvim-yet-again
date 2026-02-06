-- Theme configuration with Rosé Pine
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
}
