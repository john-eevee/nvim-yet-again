-- Add Go language support
return {
  -- Add Go treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gosum",
      })
    end,
  },

  -- Configure gopls (Go Language Server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          cmd = { "gopls" },
          settings = {
            gopls = {
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
      },
    },
  },

  -- Add Mason integration for Go tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports",
        "golines",
        "golangci-lint",
        "delve",
      })
    end,
  },

  -- Conform configuration for Go formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "golines" },
      },
    },
  },

  -- nvim-dap configuration for Go debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function(_, opts)
      local dap = require("dap")
      if not dap.adapters.delve then
        dap.adapters.delve = {
          type = "server",
          port = "${port}",
          executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
          },
        }
      end
      if not dap.configurations.go then
        dap.configurations.go = {
          {
            type = "delve",
            name = "Debug",
            mode = "debug",
            program = "${fileDirname}",
            request = "launch",
            showLog = false,
          },
          {
            type = "delve",
            name = "Debug test",
            mode = "test",
            program = "${fileDirname}",
            request = "launch",
            showLog = false,
          },
          {
            type = "delve",
            name = "Debug test (package)",
            mode = "test",
            program = "${workspaceFolder}",
            request = "launch",
            showLog = false,
          },
          {
            type = "delve",
            name = "Attach",
            mode = "local",
            request = "attach",
            processId = require("dap.utils").pick_process,
            showLog = false,
          },
        }
      end
    end,
  },
}
