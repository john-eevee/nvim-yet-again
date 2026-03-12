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
  { "echasnovski/mini.sessions", version = "*", config = function()
    require("mini.sessions").setup({
      hooks = {
        pre = {
          write = function()
            -- Save harpoon before session
            pcall(function()
              require("harpoon"):list():save()
            end)
          end,
        },
      },
    })
  end },
  { "echasnovski/mini.jump", version = "*", config = function()
    require("mini.jump").setup()
  end },
  { "echasnovski/mini.jump2d", version = "*", config = function()
    require("mini.jump2d").setup()
  end },
  { "echasnovski/mini.diff", version = "*", config = function()
    require("mini.diff").setup()
  end },
  -- mini.swap disabled - requires SSH access
  { "echasnovski/mini.splitjoin", version = "*", config = function()
    require("mini.splitjoin").setup()
  end },
  { "echasnovski/mini.move", version = "*", config = function()
    require("mini.move").setup()
  end },
  { "echasnovski/mini.align", version = "*", config = function()
    require("mini.align").setup()
  end },
  { "echasnovski/mini.clue", version = "*" },
}
