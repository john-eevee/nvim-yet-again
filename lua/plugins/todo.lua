return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo",
    },
    { "<C-A-t>d", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<C-A-t>f", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
