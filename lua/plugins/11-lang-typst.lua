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
      -- The shim only drops the --static-file-host flag that tinymist deprecated
      -- and that the plugin still passes; without it tinymist serves the preview
      -- page from the data plane host and keeps printing the line the plugin
      -- parses, so this stays working when the flag is finally removed.
      dependencies_bin = {
        tinymist = vim.fs.joinpath(vim.fn.stdpath("config"), "bin", "tinymist-preview-shim"),
      },
    },
    keys = {
      { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", ft = "typst", desc = "Toggle Typst preview" },
      { "<leader>ts", "<cmd>TypstPreviewSyncCursor<cr>", ft = "typst", desc = "Sync preview to cursor" },
    },
  },
}
