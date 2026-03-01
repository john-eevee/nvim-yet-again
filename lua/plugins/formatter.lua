return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        java = { "spotless" },
        dart = { "dart_format" },
        elixir = { "mix" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        spotless = {
          command = "gradlew",
          args = {
            "spotlessApply",
            "-PspotlessIdeHook=$FILENAME",
            "-PspotlessIdeHookUseStdIn",
            "-PspotlessIdeHookUseStdOut",
            "--quiet",
          },
          stdin = true,
          -- cwd = require("conform.util").root_file({ "gradlew", "build.gradle", "build.gradle.kts" }),
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
}
