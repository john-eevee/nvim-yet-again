return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    enabled = false,
    opts = {
      modes = {
        lsp_base = {
          params = {
            include_declaration = false,
          },
        },
      },
    },
    keys = {
         },
  },
}
