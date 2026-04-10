return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("nvim-dap-virtual-text").setup({})
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      -- dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      -- dapui.close({})
    end

    -- Java adapter is registered automatically by nvim-jdtls when it starts.
    -- Only add a remote-attach configuration here; the launch adapter and
    -- local launch configs come from nvim-jdtls / java-debug automatically.
    dap.configurations.java = dap.configurations.java or {}
    if #dap.configurations.java == 0 then
      dap.configurations.java = {
        {
          -- Attach to a JVM started with -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
          name = "Debug (Attach) - Remote",
          type = "java",
          request = "attach",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end
    -- Python (debugpy)
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          end
          return "python"
        end,
      },
    }

    -- Rust (codelldb)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.rust = {
      {
        type = "codelldb",
        name = "Debug",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- Go (delve)
    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        mode = "debug",
        program = "${fileDirname}",
        request = "launch",
      },
    }

    -- Elixir (mix task)
    dap.adapters.mix_task = {
      type = "executable",
      command = "elixir",
      args = { "--name", "debug@127.0.0.1", "-S", "mix", "test", "--trace" },
    }
    dap.configurations.elixir = {
      {
        type = "mix_task",
        name = "Debug test",
        request = "launch",
        task = "test",
        taskArgs = { "--trace" },
        projectDir = "${workspaceFolder}",
        requireFiles = {
          "test/**/test_helper.exs",
          "test/**/*_test.exs",
        },
      },
    }
    dap.adapters.dart = {
      type = "executable",
      command = "flutter",
      args = { "debug_adapter" },
      options = {},
    }
  end,
}
