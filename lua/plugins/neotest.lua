return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
      "jfpedroza/neotest-elixir",
      "mfussenegger/nvim-dap",
    },
    opts = {
      adapters = {
        ["neotest-java"] = {
          ignore_wrapper = false,
        },
        ["neotest-elixir"] = {},
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          local has_trouble = require("lazy.core.config").plugins["trouble.nvim"] ~= nil
          if has_trouble then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters) do
          if name == "neotest-java" then
            table.insert(adapters, require("neotest-java")(config))
          elseif name == "neotest-elixir" then
            table.insert(adapters, require("neotest-elixir")(config))
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  },
}
