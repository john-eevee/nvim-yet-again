return {
  { "echasnovski/mini.pairs", version = "*", config = function()
    require("mini.pairs").setup({
      mappings = {
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\]' },
      },
    })
  end },
  { "echasnovski/mini.comment", version = "*", config = function() require("mini.comment").setup() end },
  { "echasnovski/mini.ai", version = "*", config = function() require("mini.ai").setup() end },
}
