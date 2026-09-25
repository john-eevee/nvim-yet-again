-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Treesitter (v2 API)
--
-- v2 dropped `ensure_installed`, `highlight`, `indent`, `incremental_selection`
-- and the old `textobjects` block: highlighting/indentation are always on, tree
-- node selection is built into Nvim 0.12 (`an`/`in`/`]n`), parsers are declared
-- here and textobjects are keyed up by their own plugin.
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Parsers the core config relies on. Language plugins extend this list through
-- `opts.parsers` (see 05-lang-rust … 09-lang-svelte). Parsers bundled with Nvim
-- are detected at load time and never reinstalled.
local parsers = {
  "bash", "c", "css", "diff", "go", "html", "javascript", "json",
  "lua", "luadoc", "markdown", "markdown_inline", "python", "query",
  "regex", "scss", "sql", "toml", "tsx", "typescript", "vim", "vimdoc",
  "yaml",
}

local function ts_select(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

local function ts_move(method, query)
  return function()
    require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
  end
end

return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true, style = "nvchad" },
        which_key = true,
        native_lsp = { enabled = true, underlines = { errors = { "undercurl" }, hints = { "undercurl" }, warnings = { "undercurl" }, information = { "undercurl" } } },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { parsers = parsers },
    opts_extend = { "parsers" },
    config = function(_, opts)
      -- Install whatever is declared here (or by a language plugin) and cannot
      -- be loaded yet. `language.add()` returns true when a parser (bundled or
      -- installed) can be loaded and nil otherwise.
      local missing = vim.tbl_filter(function(lang)
        return not vim.treesitter.language.add(lang)
      end, opts.parsers or {})

      if #missing > 0 then
        require("nvim-treesitter.install").install(missing)
      end
    end,
  },

  -- Treesitter textobjects (configured and keyed up here in v2, not inside
  -- the nvim-treesitter opts)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
    end,
    keys = {
      { "af", mode = { "x", "o" }, ts_select("@function.outer"), desc = "Function (outer)" },
      { "if", mode = { "x", "o" }, ts_select("@function.inner"), desc = "Function (inner)" },
      { "ac", mode = { "x", "o" }, ts_select("@class.outer"), desc = "Class (outer)" },
      { "ic", mode = { "x", "o" }, ts_select("@class.inner"), desc = "Class (inner)" },
      { "]f", mode = { "n", "x", "o" }, ts_move("goto_next_start", "@function.outer"), desc = "Next function start" },
      { "]c", mode = { "n", "x", "o" }, ts_move("goto_next_start", "@class.outer"), desc = "Next class start" },
      { "]F", mode = { "n", "x", "o" }, ts_move("goto_next_end", "@function.outer"), desc = "Next function end" },
      { "]C", mode = { "n", "x", "o" }, ts_move("goto_next_end", "@class.outer"), desc = "Next class end" },
      { "[f", mode = { "n", "x", "o" }, ts_move("goto_previous_start", "@function.outer"), desc = "Previous function start" },
      { "[c", mode = { "n", "x", "o" }, ts_move("goto_previous_start", "@class.outer"), desc = "Previous class start" },
      { "[F", mode = { "n", "x", "o" }, ts_move("goto_previous_end", "@function.outer"), desc = "Previous function end" },
      { "[C", mode = { "n", "x", "o" }, ts_move("goto_previous_end", "@class.outer"), desc = "Previous class end" },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern" },
  },

  -- Surround
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Auto-pairs
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup({
        mappings = {
          ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]" },
        },
      })
    end,
  },

  -- Sessions
  {
    "echasnovski/mini.sessions",
    version = "*",
    opts = {},
  },
}
