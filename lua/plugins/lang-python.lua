-- Add Python language support with Ty, Ruff, and Uv (Astral Stack)
-- See: https://docs.astral.sh/ty/editors/
return {
  -- Add Python treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
      })
    end,
  },

  -- Configure Ty (Astral's Python type checker) as the primary LSP
  -- Ty provides fast type checking and diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ty language server for type checking (Neovim 0.10 and earlier)
        ty = {
          cmd = { "ty", "server" },
          settings = {
            ty = {
              -- Type checking mode: strict, standard, or basic
              typeCheckingMode = "standard",
              -- Additional settings for type checking
              diagnosticMode = "workspace",
            },
          },
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "pyrightconfig.json",
            "typings",
            ".git"
          ),
        },
      },
    },
  },

  -- Add Mason integration for Python tools (Astral stack)
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Type checking with Ty
        "ty",
        -- Linting and formatting with Ruff (replaces flake8, black, isort, etc.)
        "ruff",
        -- Debugging
        "debugpy",
      })
    end,
  },

  -- Conform configuration for Python formatting with Ruff
  -- Ruff is an extremely fast Python linter and formatter (written in Rust)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Ruff handles both linting and formatting (replaces black, isort, flake8)
        python = { "ruff_organize_imports", "ruff_format" },
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
      },
    },
  },

  -- nvim-dap configuration for Python debugging with debugpy
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function(_, opts)
      local dap = require("dap")
      if not dap.adapters.python then
        dap.adapters.python = {
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
        }
      end
      if not dap.configurations.python then
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              -- Try to find python from uv venv, then standard venv locations
              if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              else
                -- Fallback to system python
                return "python"
              end
            end,
          },
          {
            type = "python",
            request = "launch",
            name = "Launch Module",
            module = "${file}",
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              else
                return "python"
              end
            end,
          },
          {
            type = "python",
            request = "launch",
            name = "Debug with arguments",
            program = "${file}",
            args = function()
              local input = vim.fn.input("Arguments: ")
              return vim.split(input, " ")
            end,
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              else
                return "python"
              end
            end,
          },
        }
      end
    end,
  },

  -- Integration with uv (Astral's Python package manager)
  -- If you have uv available, it will be used for project detection
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Enable Ty for all Python files in projects with uv
      local lspconfig = require("lspconfig")
      if not lspconfig.ty.manager then
        lspconfig.ty.setup({
          on_attach = function(client, bufnr)
            -- Optional: add custom keybinds or behavior
          end,
        })
      end
      return opts
    end,
  },
}
