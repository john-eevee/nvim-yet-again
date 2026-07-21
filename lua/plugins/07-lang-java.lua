return {
  -- nvim-java (handles jdtls setup + debugging)
  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup()

      -- Discover Java runtimes from mise installations
      local runtimes = {}
      local mise_java_dir = vim.fn.expand("~/.local/share/mise/installs/java")
      local handle = vim.loop.fs_scandir(mise_java_dir)
      if handle then
        while true do
          local name = vim.loop.fs_scandir_next(handle)
          if not name then break end
          local full_path = mise_java_dir .. "/" .. name
          if vim.fn.isdirectory(full_path) == 1 then
            local ver = name:match("%d+") or ""
            table.insert(runtimes, {
              name = "JavaSE-" .. ver,
              path = full_path,
              default = #runtimes == 0,
            })
          end
        end
      end

      -- Fallback: try to find active mise Java
      if #runtimes == 0 then
        local active_java = vim.fn.trim(vim.fn.system("mise where java 2>/dev/null") or "")
        if active_java ~= "" then
          table.insert(runtimes, {
            name = "JavaSE",
            path = active_java,
            default = true,
          })
        end
      end

      vim.lsp.enable("jdtls")
      vim.lsp.config("jdtls", {
        settings = {
          java = {
            configurations = {
              runtimes = #runtimes > 0 and runtimes or nil,
            },
          },
        },
      })
    end,
  },
}
