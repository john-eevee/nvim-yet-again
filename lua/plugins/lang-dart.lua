-- Add Dart and Flutter support
return {
  -- Add Dart treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "dart",
      })
    end,
  },

  -- Add Mason integration for Dart formatters and LSP
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "dart-debug-adapter",
      })
    end,
  },

  -- Flutter support with flutter-tools
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          -- flutter-tools UI customization
          enable_devtools = true,
          enable_devtools_server = true,
          devtools_port = 9100,
          custom_styles = {},
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
          exception_breakpoints = {},
        },
        flutter_path = nil,
        flutter_lookup_cmd = nil,
        root_patterns = { "pubspec.yaml", ".dart_tool" },
        fvm = false,
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "ErrorMsg",
          prefix = ">",
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          on_attach = nil,
          capabilities = nil,
          settings = {
            showTodos = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = {},
            lineLength = 80,
          },
        },
      })

      -- Flutter-specific keymaps
      local map = vim.keymap.set
      map("n", "<leader>fa", "<cmd>FlutterRun<CR>", { noremap = true, desc = "Flutter: Run" })
      map("n", "<leader>fq", "<cmd>FlutterQuit<CR>", { noremap = true, desc = "Flutter: Quit" })
      map("n", "<leader>fr", "<cmd>FlutterReload<CR>", { noremap = true, desc = "Flutter: Reload" })
      map("n", "<leader>fR", "<cmd>FlutterRestart<CR>", { noremap = true, desc = "Flutter: Restart" })
      map("n", "<leader>fD", "<cmd>FlutterDevices<CR>", { noremap = true, desc = "Flutter: Devices" })
    end,
  },

  -- nvim-dap configuration for Dart
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mason.nvim",
      "flutter-tools.nvim",
    },
  },
}
