return {
  "wezterm-jdb",
  dir = vim.fn.stdpath("config") .. "/lua/local-plugins/wezterm-jdb",
  ft = "java",
  config = function()
    local function send_breakpoint_to_jdb()
      -- 1. Grab the current line number
      local line_num = vim.api.nvim_win_get_cursor(0)[1]

      -- 2. Grab the file name without the extension to use as the class name
      local class_name = vim.fn.expand("%:t:r")

      -- 3. Use Treesitter to find the package name safely
      local bufnr = vim.api.nvim_get_current_buf()
      local parser = vim.treesitter.get_parser(bufnr, "java")
      local tree = parser:parse()[1]
      local root = tree:root()

      local query_string = [[
        (package_declaration
          [
            (scoped_identifier) @pkg
            (identifier) @pkg
          ]
        )
      ]]

      local query = vim.treesitter.query.parse("java", query_string)
      local pkg_name = ""

      for id, node in query:iter_captures(root, bufnr, 0, -1) do
        if query.captures[id] == "pkg" then
          pkg_name = vim.treesitter.get_node_text(node, bufnr)
          break
        end
      end

      if pkg_name == "" then
        print("Girl, I could not find the Java package! Are you sure this is a valid Java file?")
        return
      end

      -- 4. Put the command together
      local jdb_cmd = string.format("stop at %s.%s:%s", pkg_name, class_name, line_num)

      -- 5. Find the Wezterm pane running jdb
      local get_pane_cmd =
        [[wezterm cli list --format json | jq -r '.[] | select(.title | test("jdb"; "i")) | .pane_id' | head -n 1]]

      local pane_id = vim.trim(vim.fn.system(get_pane_cmd))

      if pane_id == "" then
        print("Ugh, no! 😭 I could not find a Wezterm pane running jdb. Are you sure it is open?")
        return
      end

      -- 6. Send the text directly to that specific pane ID
      local send_cmd = string.format("wezterm cli send-text --pane-id %s '%s\n'", pane_id, jdb_cmd)
      vim.fn.system(send_cmd)

      print("✨ Sent breakpoint to jdb (Pane " .. pane_id .. ")!")
    end

    -- Map this fabulous function to a shortcut
    vim.keymap.set("n", "<leader>db", send_breakpoint_to_jdb, {
      buffer = true,
      desc = "Send breakpoint to jdb in Wezterm pane",
    })
  end,
}
