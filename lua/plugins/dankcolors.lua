-- Lightweight, aesthetic Catppuccin theme wrapper
local set_hl = vim.api.nvim_set_hl

local palette = {
  visual_bg = '#2a2f3a',
  visual_fg = '#e6eef6',
  status_bg = '#16161a',
  status_fg = '#cdd6f4',
  line_nr = '#5c6370',
  func = '#d0d4e5',
  stmt = '#7aa2f7',
  ty = '#9aa3e7',
  str = '#86e086',
  comment = '#5c6370',
  op = '#abb2bf',
}

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        transparent_background = false,
        term_colors = true,
        dim_inactive = { enabled = true, percentage = 0.12 },
        styles = { comments = { 'italic' }, functions = { 'bold' } },
        integrations = { cmp = true, gitsigns = true, telescope = true, treesitter = true, native_lsp = { enabled = true } },
      })

      vim.cmd('colorscheme catppuccin')

      -- concise highlights for a clean, sleek look
      set_hl(0, 'Visual', { bg = palette.visual_bg, fg = palette.visual_fg })
      set_hl(0, 'Statusline', { bg = palette.status_bg, fg = palette.status_fg })
      set_hl(0, 'LineNr', { fg = palette.line_nr })
      set_hl(0, 'CursorLineNr', { fg = palette.ty, bold = true })

      set_hl(0, 'Statement', { fg = palette.stmt, bold = true })
      set_hl(0, 'Keyword', { link = 'Statement' })

      set_hl(0, 'Function', { fg = palette.func, bold = true })
      set_hl(0, 'Type', { fg = palette.ty, italic = true })
      set_hl(0, 'String', { fg = palette.str, italic = true })

      set_hl(0, 'Delimiter', { fg = palette.op })
      set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })

      set_hl(0, 'Comment', { fg = palette.comment, italic = true })

      -- file watcher: reload theme on save for iterative tweaks
      local file = vim.fn.stdpath('config') .. '/lua/plugins/dankcolors.lua'
      if not _G._dank_theme_watcher then
        local uv = vim.uv or vim.loop
        _G._dank_theme_watcher = uv.new_fs_event()
        _G._dank_theme_watcher:start(file, {}, vim.schedule_wrap(function()
          local ok, spec = pcall(dofile, file)
          if ok and spec and spec[1] and spec[1].config then
            spec[1].config()
            vim.schedule(function() print('dankcolors: theme reloaded') end)
          end
        end))
      end
    end,
  },
}
