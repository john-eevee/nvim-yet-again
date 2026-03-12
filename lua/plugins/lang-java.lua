-- Add Java language support with Gradle and Maven
return {
  -- Add Java treesitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "java",
      })
    end,
  },

  -- Add Mason integration for Java tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- LSP
        "jdtls",
        -- Debugging
        "java-debug-adapter",
        "java-test",
      })
    end,
  },

  -- nvim-dap configuration for Java debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function(_, opts)
      local dap = require("dap")
      if not dap.adapters.java then
        dap.adapters.java = function(callback, config)
          callback({
            type = "server",
            host = "127.0.0.1",
            port = 5005,
          })
        end
      end
      if not dap.configurations.java then
        dap.configurations.java = {
          {
            name = "Debug (Attach) - Remote",
            type = "java",
            request = "attach",
            hostName = "127.0.0.1",
            port = 5005,
            preLaunchTask = "java: Start debugging session",
          },
        }
      end
    end,
  },

  -- nvim-jdtls for enhanced Java support
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local jdtls = require("jdtls")
      local jdtls_setup = require("jdtls.setup")

      -- Get the java command
      local java_cmd = "java"
      local java_home = os.getenv("JAVA_HOME")
      if java_home then
        java_cmd = java_home .. "/bin/java"
      end

      -- Compute the bundles directory
      local bundles_dir = vim.fn.stdpath("cache") .. "/nvim_jdtls_bundles"
      local bundles = {}
      if vim.fn.isdirectory(bundles_dir) == 1 then
        for file in vim.loop.fs_scandir(bundles_dir) do
          if file:match("%.jar$") then
            table.insert(bundles, bundles_dir .. "/" .. file)
          end
        end
      end

      local config = {
        cmd = {
          java_cmd,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=WARN",
          "-Xms1g",
          "-Xmx2g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
          "-data", vim.fn.stdpath("cache") .. "/jdtls-workspace",
          "--jvm-arg=-XX:+UseParallelGC",
          "--jvm-arg=-XX:GCTimeRatio=4",
          "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
          "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
        },
        root_dir = require("jdtls.setup").find_root({ "build.xml", "pom.xml", "gradle.build", ".git" }),
        settings = {
          java = {
            home = java_home,
          },
        },
        init_options = {
          bundles = bundles,
        },
      }

      jdtls.start_or_attach(config)
    end,
  },
}
