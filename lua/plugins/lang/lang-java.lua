-- Add Java language support with Gradle and Maven
return {
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

      local java_cmd = "java"
      local java_home = os.getenv("JAVA_HOME")
      if java_home then
        java_cmd = java_home .. "/bin/java"
      end

      -- Per-project workspace so the index survives reboots.
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

      -- java-debug bundle (required for DAP launch/attach)
      local bundles = {
        vim.fn.glob(
          vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
          1
        ),
      }

      -- vscode-java-test bundles (required for test_class / test_nearest_method)
      local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"
      local java_test_jars = vim.split(vim.fn.glob(java_test_path .. "/*.jar", 1), "\n", { trimempty = true })
      local excluded_jars = { "com.microsoft.java.test.runner-jar-with-dependencies.jar", "jacocoagent.jar" }
      for _, jar in ipairs(java_test_jars) do
        local fname = vim.fn.fnamemodify(jar, ":t")
        if not vim.tbl_contains(excluded_jars, fname) then
          table.insert(bundles, jar)
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
          "-data", workspace_dir,
        },
        root_dir = require("jdtls.setup").find_root({ "build.xml", "pom.xml", "gradle.build", "gradle.build.kts", ".git" }),
        settings = {
          java = {
            home = java_home,
          },
        },
        -- Bundles enable java-debug (DAP) and vscode-java-test inside eclipse.jdt.ls
        init_options = {
          bundles = bundles,
        },
      }

      jdtls.start_or_attach(config)

      -- DAP keymaps for Java tests (requires java-debug + vscode-java-test bundles)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
      end
      map("n", "<S-F9>", function() jdtls.test_class() end, "Debug test class")
      map("n", "<S-F9>", function() jdtls.test_nearest_method() end, "Debug nearest test method")
    end,
  },
}

