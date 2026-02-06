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

  -- Configure JDTLS (Java Language Server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          settings = {
            java = {
              project = {
                referencedLibraries = {
                  "$JAVA_HOME/lib/**/*.jar",
                },
              },
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              implementation = {
                searchAllProjectsScope = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              signatureHelp = {
                enabled = true,
                description = {
                  enabled = true,
                },
              },
              contentProvider = "fernflower",
              autobuild = {
                enabled = true,
              },
              saveActions = {
                organizeImports = true,
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = "${object}.toString()",
                },
                hashCodeEquals = {
                  useInstanceof = true,
                  useJava7Objects = true,
                },
                useBlocks = true,
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-11",
                    path = os.getenv("JAVA_HOME") or "/usr/lib/jvm/java-11",
                    default = true,
                  },
                  {
                    name = "JavaSE-17",
                    path = os.getenv("JAVA_HOME_17") or "/usr/lib/jvm/java-17",
                  },
                },
              },
              format = {
                enabled = true,
                settings = {
                  url = os.getenv("JAVA_FORMAT_SETTINGS_URL"),
                  profile = os.getenv("JAVA_FORMAT_SETTINGS_PROFILE"),
                },
              },
            },
          },
        },
      },
    },
  },

  -- Add Mason integration for Java tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "jdtls",
        "java-debug-adapter",
        "java-test",
      })
    end,
  },

  -- Conform configuration for Java formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google_java_format" },
      },
    },
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

      -- Key mappings for JDTLS
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<leader>jc", jdtls.compile, vim.tbl_extend("force", opts, { desc = "Java: Compile" }))
      map("n", "<leader>jC", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Java: Organize imports" }))
      map("n", "<leader>je", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Java: Extract variable" }))
      map("n", "<leader>jm", jdtls.extract_method, vim.tbl_extend("force", opts, { desc = "Java: Extract method" }))
    end,
  },
}
