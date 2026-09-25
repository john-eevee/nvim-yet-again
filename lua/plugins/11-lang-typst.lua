-- Typst: tinymist language server + live preview
return {
  -- Treesitter parser for Typst
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { parsers = { "typst" } },
  },

  -- Typst language server (installed by mason, see 03-lsp.lua)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },

  -- Live preview in the browser, driven by tinymist's preview server
  {
    "chomosuke/typst-preview.nvim",
    version = "1.*",
    ft = "typst",
    opts = {
      -- Reuse mason's tinymist instead of letting the plugin download its own
      -- pinned copy (websocat is still fetched into stdpath/data on setup).
      dependencies_bin = { tinymist = "tinymist" },
    },
    keys = {
      { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", ft = "typst", desc = "Toggle Typst preview" },
      { "<leader>ts", "<cmd>TypstPreviewSyncCursor<cr>", ft = "typst", desc = "Sync preview to cursor" },
    },
  },
}
