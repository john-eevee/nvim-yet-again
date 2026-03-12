return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
        go = { "goimports", "golines" },
        java = { "spotless" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        elixir = {"mix"}
      },
      formatters = {
        ruff_organize_imports = {
          command = "ruff",
          args = { "check", "--select", "I", "--fix", "-" },
          stdin = true,
        },
        ruff_format = {
          command = "ruff",
          args = { "format", "-" },
          stdin = true,
        },
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
          cwd = function()
            require("conform.util").root_file({ "gradlew", "build.gradle", "build.gradle.kts" })
          end,
        },
      },
    },
  },
}
