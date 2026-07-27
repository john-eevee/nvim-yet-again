-- Flutter/Dart support: LSP is managed by flutter-tools, not lspconfig/mason
return {
  -- Flutter tools (handles LSP + debugging + widgets)
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      -- Resolve flutter via mise
      local flutter_bin = vim.fn.trim(vim.fn.system("mise which flutter 2>/dev/null") or "")

      require("flutter-tools").setup({
        flutter_path = flutter_bin ~= "" and flutter_bin or nil,
        ui = {
          enable_devtools = true,
          border = "rounded",
          notification_style = "native",
        },
        decorations = {
          childs = true,
          color = true,
          row_numbers = true,
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
        widget_guides = { enabled = true },
        closing_tags = { highlight = "ErrorMsg", prefix = ">", enabled = true },
        lsp = {
          capabilities = nil,
          settings = {
            showTodos = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            lineLength = 80,
          },
        },
      })
    end,
  },

  -- Dressing.nvim (needed by flutter-tools for UI)
  { "stevearc/dressing.nvim", lazy = true },
}
