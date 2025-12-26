-- ╔══════════════════════════════════════════════════════════════╗
-- ║          LUASNIP - SNIPPET ENGINE & MANAGEMENT                ║
-- ║     Create and manage code snippets for faster editing        ║
-- ╚══════════════════════════════════════════════════════════════╝

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SNIPPET CREATION COMMAND
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Helper function to create custom snippets directory
local function ensure_snippets_dir()
  local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
  if vim.fn.empty(vim.fn.glob(snippets_dir)) > 0 then
    vim.fn.mkdir(snippets_dir, "p")
  end
  return snippets_dir
end

-- Create snippets directory
ensure_snippets_dir()

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CUSTOM SNIPPET LOADERS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").load()

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- USER COMMAND FOR SNIPPET CREATION
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.api.nvim_create_user_command("SnippetCreate", function()
  local name = vim.fn.input("Snippet name: ")
  if name == "" then
    return
  end

  local filetype = vim.bo.filetype
  local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
  local snippet_file = snippets_dir .. "/" .. filetype .. ".json"

  if vim.fn.filereadable(snippet_file) == 0 then
    vim.fn.writefile({ "{" .. '  "' .. name .. '": {', '    "prefix": "' .. name .. '",' .. '    "body": [', '      ""', "    ]," .. '    "description": ""', "  }", "}" }, snippet_file)
  else
    print("Snippet file created at: " .. snippet_file)
  end

  vim.cmd("edit " .. snippet_file)
end, {})

-- Keybind for creating snippets
vim.keymap.set(
  "n",
  "<leader>snip",
  ":SnippetCreate<CR>",
  { noremap = true, silent = true, desc = "Snippets: Create new snippet" }
)
