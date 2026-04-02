return {
  "nvim-java/nvim-java",
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
    vim.lsp.config("jdtls", {
      settings = {
        java = {
          configurations = {
            runtimes = {
              {
                name = "JavaSE-25",
                path = "/home/john/.local/share/mise/shims",
                default = true,
              },
            },
          },
        },
      },
    })
  end,
}
