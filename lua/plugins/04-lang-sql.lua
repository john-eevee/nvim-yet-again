return {
  -- vim-dadbod: database client
  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = "DB",
  },

  -- vim-dadbod-ui: database browser UI
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_execute_on_save = 0
    end,
  },

  -- vim-dadbod-completion: auto-completion for SQL
  -- IMPORTANT: This is a TOP-LEVEL plugin (not nested), so it loads independently
  -- on FileType sql/mysql/plsql, making the blink.cmp provider available
  -- before blink tries to initialize its sources for those filetypes.
  {
    "kristijanhusak/vim-dadbod-completion",
    lazy = true,
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
}
