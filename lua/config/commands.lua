-- ╔══════════════════════════════════════════════════════════════╗
-- ║         CUSTOM COMMANDS - USER-DEFINED VIM COMMANDS          ║
-- ║    Helper commands for navigation and development tasks       ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYMAPS COMMAND - Browse and Edit All Keybindings
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Extract keymap information from vim.keymap.get()
--- @return table
local function get_all_keymaps()
  local keymaps = {}

  -- Get keymaps using vim.keymap.get() API
  local modes = { 'n', 'i', 'v', 'c', 't', 'x', 'o' }

  for _, mode in ipairs(modes) do
    local mode_maps = vim.keymap.get(mode)
    for _, map in ipairs(mode_maps) do
      if map.lhs then
        table.insert(keymaps, {
          mode = mode,
          lhs = map.lhs,
          rhs = map.rhs or "(callback)",
          desc = map.desc or "",
          noremap = map.noremap or false,
          silent = map.silent or false,
        })
      end
    end
  end

  -- Sort by mode and lhs
  table.sort(keymaps, function(a, b)
    if a.mode ~= b.mode then
      return a.mode < b.mode
    end
    return a.lhs < b.lhs
  end)

  return keymaps
end

--- Format keymaps for display in scratch buffer
--- @param keymaps table List of keymap tables
--- @return string Formatted text
local function format_keymaps_for_display(keymaps)
  if vim.tbl_isempty(keymaps) then
    return "No keymaps found"
  end

  local lines = {}
  table.insert(lines, "╔════════════════════════════════════════════════════════════════╗")
  table.insert(lines, "║              KEYMAPS - BROWSE ALL KEYBINDINGS                  ║")
  table.insert(lines, "║  Press gf to go to file, search with /, type q to close        ║")
  table.insert(lines, "╚════════════════════════════════════════════════════════════════╝")
  table.insert(lines, "")
  table.insert(lines, "KEY LEGEND:")
  table.insert(lines, "  n: Normal mode    |  i: Insert mode    |  v: Visual mode")
  table.insert(lines, "  c: Command mode   |  t: Terminal mode  |  x: Selection")
  table.insert(lines, "  o: Operator mode")
  table.insert(lines, "")
  table.insert(lines, "NAVIGATION:")
  table.insert(lines, "  /         Search for keymap")
  table.insert(lines, "  *         Search word under cursor")
  table.insert(lines, "  <C-f/b>   Page down/up")
  table.insert(lines, "  q         Close buffer")
  table.insert(lines, "")
  table.insert(lines, "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  table.insert(lines, "")

  local current_mode = nil
  for _, keymap in ipairs(keymaps) do
    if keymap.mode ~= current_mode then
      current_mode = keymap.mode
      table.insert(lines, "")
      local mode_names = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        c = "COMMAND",
        t = "TERMINAL",
        x = "SELECTION",
        o = "OPERATOR",
      }
      table.insert(lines, string.format("─── %s MODE ───", mode_names[current_mode] or current_mode))
      table.insert(lines, "")
    end

    -- Format the keymap line with proper alignment
    local rhs_display = tostring(keymap.rhs):sub(1, 35)
    local line = string.format(
      "  %-15s → %-37s %s",
      keymap.lhs,
      rhs_display,
      keymap.desc ~= "" and ("│ " .. keymap.desc) or ""
    )
    table.insert(lines, line)
  end

  table.insert(lines, "")
  table.insert(lines, "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  table.insert(lines, "Total keymaps: " .. #keymaps)

  return table.concat(lines, "\n")
end

--- Open keymaps in a scratch buffer
local function open_keymaps_buffer()
  -- Get all keymaps
  local keymaps = get_all_keymaps()

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  -- Format and set content
  local formatted = format_keymaps_for_display(keymaps)
  local lines = vim.split(formatted, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set buffer name
  vim.api.nvim_buf_set_name(buf, "Keymaps")

  -- Open buffer in current window or split
  vim.api.nvim_set_current_buf(buf)

  -- Set filetype for better highlighting
  vim.bo.filetype = "keymaps"
  vim.bo.modifiable = false -- Make it read-only by default

  -- Add helpful keymaps for this buffer
  local keymap_opts = { noremap = true, silent = true, buffer = buf }

  -- Close with q or Escape
  vim.keymap.set(
    "n",
    "q",
    "<cmd>bdelete<CR>",
    vim.tbl_extend("force", keymap_opts, { desc = "Close keymaps" })
  )
  vim.keymap.set(
    "n",
    "<Esc>",
    "<cmd>bdelete<CR>",
    vim.tbl_extend("force", keymap_opts, { desc = "Close keymaps" })
  )

  -- Search functionality
  vim.keymap.set(
    "n",
    "/",
    ":",
    vim.tbl_extend("force", keymap_opts, { desc = "Search in keymaps" })
  )

  -- Log keymaps buffer open
  require("utils.logger").info("Keymaps: Keymaps buffer opened. Press 'q' or <Esc> to close, '/' to search.")
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TEST INTEGRATION - Click Test Output to Open in Neovim
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Create a Kitty OSC 8 hyperlink for a file path
--- @param path string File path (can be "file:line" or "file:line:col")
--- @param text string Display text for the hyperlink
--- @return string Hyperlinked text
local function create_hyperlink(path, text)
  -- Parse path:line:col format
  local file, line, col = path:match("([^:]+):?(%d*):?(%d*)")

  -- Expand relative paths to absolute
  if file and not file:match("^/") then
    file = vim.fn.getcwd() .. "/" .. file
  end

  -- Create OSC 8 hyperlink (works in Kitty, iTerm2, etc.)
  -- Format: OSC 8 ; ; file://path/to/file ; text OST
  -- In terminals: \x1b]8;;file://path\x1b\\ text \x1b]8;;\x1b\\
  local hyperlink = string.format(
    "\x1b]8;;file://%s\x1b\\%s\x1b]8;;\x1b\\",
    file,
    text or path
  )

  return hyperlink
end

--- Format test output with clickable file links
--- Parses common test output patterns and adds hyperlinks
--- @param output string Test output text
--- @return string Formatted output with hyperlinks
local function format_test_output_with_links(output)
  local lines = vim.split(output, "\n")
  local result = {}

  for _, line in ipairs(lines) do
    -- Match patterns like "path/to/file.js:123:45" or "at path/to/file.js:123"
    -- Patterns for common test frameworks:
    -- Jest, Vitest, Node: "path/file.js:123"
    -- Python/pytest: "path/file.py:123"
    -- Ruby/RSpec: "path/file.rb:123"
    -- Go: "path/file.go:123"
    -- Rust: "path/file.rs:123"

    local modified = line:gsub(
      "([%w_%-%.%/]+%.%w+):(%d+)(?::(%d+))?",
      function(file, line_num, col_num)
        local path = file .. ":" .. line_num .. (col_num and ":" .. col_num or "")
        return create_hyperlink(path, file .. ":" .. line_num)
      end
    )

    table.insert(result, modified)
  end

  return table.concat(result, "\n")
end

--- Run a test command and display output with clickable links in a split
--- @param cmd string Command to run (e.g., "pytest", "npm test", "cargo test")
local function run_tests_with_links(cmd)
  if not cmd or cmd == "" then
    require("utils.logger").error("Test Runner: No test command provided")
    return
  end

  require("utils.logger").info("Test Runner: Running tests: " .. cmd)

  -- Create a new buffer for test output
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  -- Open in vertical split
  vim.cmd("vert split")
  vim.api.nvim_set_current_buf(buf)

  -- Set buffer name and filetype
  vim.api.nvim_buf_set_name(buf, "Test Output")
  vim.bo.filetype = "testoutput"

  -- Add initial loading message
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running: " .. cmd, "", "..." })

  -- Run command asynchronously
  local function on_exit(job_id, code)
    -- Read output from job (vim-jobstart would be used for this)
    require("utils.logger").info("Test Runner: Tests completed with exit code: " .. code)
  end

  -- Use vim.system for async execution (Neovim 0.10+)
  if vim.system then
    local full_cmd = cmd .. " 2>&1"
    local result_lines = {}

    local job = vim.system(vim.fn.split(cmd, " "), {
      stdout = function(err, data)
        if data then
          for line in vim.gsplit(data, "\n") do
            if line ~= "" then
              table.insert(result_lines, line)
            end
          end
        end
      end,
    }, function(obj)
      -- Format with hyperlinks
      local formatted = format_test_output_with_links(table.concat(result_lines, "\n"))
      local lines = vim.split(formatted, "\n")

      -- Update buffer
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_buf_set_option(buf, "modifiable", false)

      -- Add help text
      vim.api.nvim_buf_set_option(buf, "modifiable", true)
      table.insert(lines, "")
      table.insert(lines, "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
      table.insert(lines, "Ctrl+Click on file paths to open them in Neovim")
      table.insert(lines, "Press 'q' to close this window")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_buf_set_option(buf, "modifiable", false)

      if obj.code == 0 then
        require("utils.logger").info("Test Runner: ✓ All tests passed!")
      else
        require("utils.logger").warn("Test Runner: ✗ Tests failed (exit code: " .. obj.code .. ")")
      end
    end)
  else
    -- Fallback for older Neovim versions using jobstart
    local job_id = vim.fn.jobstart(cmd, {
      on_stdout = function(id, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then
              vim.api.nvim_buf_set_option(buf, "modifiable", true)
              vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
              vim.api.nvim_buf_set_option(buf, "modifiable", false)
            end
          end
        end
      end,
      on_exit = on_exit,
    })
  end

  -- Buffer-local keymaps
  local keymap_opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set("n", "q", "<cmd>bdelete<CR>", vim.tbl_extend("force", keymap_opts, { desc = "Close test output" }))
  vim.keymap.set("n", "<Esc>", "<cmd>bdelete<CR>", vim.tbl_extend("force", keymap_opts, { desc = "Close test output" }))

  -- Make URLs clickable with gx (Neovim built-in)
  vim.keymap.set("n", "gx", function()
    local line = vim.fn.getline(".")
    -- Extract file:line from line if present
    local file = line:match("([%w_%-%.%/]+%.%w+):(%d+)")
    if file then
      vim.cmd("edit " .. file)
    end
  end, vim.tbl_extend("force", keymap_opts, { desc = "Open file under cursor" }))
end

--- Copy file path to system clipboard
--- Copies the relative path from project root
local function copy_file_path()
  local file = vim.fn.expand("%:p")
  if file == "" or file == ":" then
    require("utils.logger").warn("Copy Path: No file in current buffer")
    return
  end

  -- Try to get relative path from project root
  local cwd = vim.fn.getcwd()
  local rel_path = file
  if file:sub(1, #cwd) == cwd then
    rel_path = file:sub(#cwd + 2) -- +2 to skip the /
  end

  -- Copy to system clipboard (supports wl-copy, xclip, pbcopy)
  -- Using bash -c to ensure compatibility with Fish shell
  vim.fn.system({ "bash", "-c", "echo -n '" ..
  rel_path:gsub("'", "'\\\\''") ..
  "' | wl-copy 2>/dev/null || echo -n '" ..
  rel_path:gsub("'", "'\\\\''") ..
  "' | xclip -selection clipboard 2>/dev/null || echo -n '" .. rel_path:gsub("'", "'\\\\''") .. "' | pbcopy" })
  require("utils.logger").info("Copy Path: Copied: " .. rel_path)
end

--- Copy file path with line number to system clipboard
--- Copies the relative path with :line format
local function copy_file_path_with_line()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  if file == "" or file == ":" then
    require("utils.logger").warn("Copy Path: No file in current buffer")
    return
  end

  -- Try to get relative path from project root
  local cwd = vim.fn.getcwd()
  local rel_path = file
  if file:sub(1, #cwd) == cwd then
    rel_path = file:sub(#cwd + 2) -- +2 to skip the /
  end

  local path_with_line = rel_path .. ":" .. line

  -- Copy to system clipboard (supports wl-copy, xclip, pbcopy)
  -- Using bash -c to ensure compatibility with Fish shell
  vim.fn.system({ "bash", "-c", "echo -n '" ..
  path_with_line:gsub("'", "'\\\\''") ..
  "' | wl-copy 2>/dev/null || echo -n '" ..
  path_with_line:gsub("'", "'\\\\''") ..
  "' | xclip -selection clipboard 2>/dev/null || echo -n '" .. path_with_line:gsub("'", "'\\\\''") .. "' | pbcopy" })
  require("utils.logger").info("Copy Path: Copied: " .. path_with_line)
end

--- Quick test runner interface
--- Detects test runner and runs appropriate tests
local function run_tests_auto()
  local cwd = vim.fn.getcwd()
  local cmd = nil

  -- Detect test framework from project files
  if vim.fn.filereadable(cwd .. "/pubspec.yaml") == 1 then
    -- Flutter project
    cmd = "flutter test"
  elseif vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
    -- Maven
    cmd = "mvn test"
  elseif vim.fn.filereadable(cwd .. "/build.gradle") == 1 or vim.fn.filereadable(cwd .. "/build.gradle.kts") == 1 then
    -- Gradle
    cmd = "gradle test"
  elseif vim.fn.filereadable(cwd .. "/mix.exs") == 1 then
    -- Elixir
    cmd = "mix test"
  elseif vim.fn.filereadable(cwd .. "/package.json") == 1 then
    local package = vim.fn.readfile(cwd .. "/package.json")
    local content = table.concat(package)
    if content:match("vitest") then
      cmd = "vitest"
    elseif content:match("jest") then
      cmd = "npm test"
    else
      cmd = "npm test"
    end
  elseif vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 then
    cmd = "pytest"
  elseif vim.fn.filereadable(cwd .. "/Cargo.toml") == 1 then
    cmd = "cargo test"
  elseif vim.fn.filereadable(cwd .. "/Gemfile") == 1 then
    cmd = "bundle exec rspec"
  elseif vim.fn.filereadable(cwd .. "/go.mod") == 1 then
    cmd = "go test ./..."
  else
    -- Fallback: ask user
    cmd = vim.fn.input("Test command: ", "")
  end

  if cmd and cmd ~= "" then
    run_tests_with_links(cmd)
  end
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- REGISTER COMMANDS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Create the Keymaps command
vim.api.nvim_create_user_command("Keymaps", open_keymaps_buffer, {
  desc = "Open keymaps in scratch buffer for browsing and searching",
})

-- Add keymap to open keymaps
vim.keymap.set(
  "n",
  "<leader>km",
  "<cmd>Keymaps<CR>",
  { noremap = true, silent = true, desc = "Keymaps: Browse all bindings" }
)

-- Test runner commands
vim.api.nvim_create_user_command("Test", function(opts)
  if opts.args and opts.args ~= "" then
    run_tests_with_links(opts.args)
  else
    run_tests_auto()
  end
end, {
  nargs = "?",
  desc = "Run tests with clickable output. Usage: :Test [command]",
})

-- Quick test shortcuts
vim.keymap.set(
  "n",
  "<leader>ta",
  function() run_tests_auto() end,
  { noremap = true, silent = true, desc = "Tests: Auto-detect and run" }
)

vim.keymap.set(
  "n",
  "<leader>tp",
  function() run_tests_with_links("pytest") end,
  { noremap = true, silent = true, desc = "Tests: Run pytest" }
)

vim.keymap.set(
  "n",
  "<leader>tj",
  function() run_tests_with_links("npm test") end,
  { noremap = true, silent = true, desc = "Tests: Run npm test" }
)

vim.keymap.set(
  "n",
  "<leader>tc",
  function() run_tests_with_links("cargo test") end,
  { noremap = true, silent = true, desc = "Tests: Run cargo test" }
)

-- Copy file path utilities
vim.api.nvim_create_user_command("CopyPath", copy_file_path, {
  desc = "Copy relative file path to clipboard",
})

vim.api.nvim_create_user_command("CopyPathLine", copy_file_path_with_line, {
  desc = "Copy file path with line number to clipboard",
})

vim.keymap.set(
  "n",
  "<leader>yp",
  copy_file_path,
  { noremap = true, silent = true, desc = "Yank: Copy file path" }
)

vim.keymap.set(
  "n",
  "<leader>yl",
  copy_file_path_with_line,
  { noremap = true, silent = true, desc = "Yank: Copy file path with line" }
)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- OPENCODE CLI - Open in Right Split
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--- Open Opencode CLI in a tmux split or fallback to buffer
local function open_opencode_cli_split()
  local tmux_session = vim.fn.getenv("TMUX")

  -- Try to open in tmux split if in a tmux session
  if tmux_session and tmux_session ~= vim.NIL and tmux_session ~= "" then
    local split_cmd = "tmux split-window -h -c '#{pane_current_path}' 'opencode'"
    local result = vim.fn.system(split_cmd)

    if vim.v.shell_error == 0 then
      require("utils.logger").info("Opencode CLI: Opened in new tmux split")
      return
    else
      require("utils.logger").warn("Opencode CLI: Failed to open in tmux, falling back to buffer")
    end
  end

  -- Fallback: Create a new buffer for Opencode CLI
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "terminal", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })

  -- Open in vertical right split
  vim.cmd("rightbelow vsplit")
  vim.api.nvim_set_current_buf(buf)

  -- Set buffer name
  vim.api.nvim_buf_set_name(buf, "Opencode CLI")
  vim.bo.filetype = "opencode"

  -- Start the Opencode CLI in the terminal
  local term_chan = vim.api.nvim_open_term(buf, {})
  vim.fn.chansend(term_chan, "opencode\n")

  -- Buffer-local keymaps
  local keymap_opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set("n", "q", "<cmd>bdelete<CR>", vim.tbl_extend("force", keymap_opts, { desc = "Close Opencode CLI" }))

  require("utils.logger").info("Opencode CLI: Opened in right split (buffer)")
end

-- Create the Opencode command
vim.api.nvim_create_user_command("Opencode", open_opencode_cli_split, {
  desc = "Open Opencode CLI in a right split buffer",
})

-- Add keymap to open Opencode CLI
vim.keymap.set(
  "n",
  "<leader>oo",
  "<cmd>Opencode<CR>",
  { noremap = true, silent = true, desc = "Opencode: Open CLI in right split" }
)
