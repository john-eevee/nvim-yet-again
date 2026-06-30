return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    enabled = true,
    opts = {
      modes = {
        lsp_base = {
          params = {
            include_declaration = false,
          },
        },
      },
    },
    keys = {},
  },
}
