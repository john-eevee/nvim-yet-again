return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- options: latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = { 'italic' },
          functions = { 'bold' },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
          treesitter = true,
          native_lsp = { enabled = true },
        },
      })

      vim.cmd('colorscheme catppuccin')

      -- keep existing custom highlights from previous theme (overrides)
      vim.api.nvim_set_hl(0, 'Visual', { bg = '#5c6370', fg = '#ffffff', bold = true })
      vim.api.nvim_set_hl(0, 'Statusline', { bg = '#d0d4e5', fg = '#131315' })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5c6370' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#7473b1', bold = true })

      vim.api.nvim_set_hl(0, 'Statement', { fg = '#6079ad', bold = true })
      vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

      vim.api.nvim_set_hl(0, 'Function', { fg = '#d0d4e5', bold = true })
      vim.api.nvim_set_hl(0, 'Macro', { fg = '#d0d4e5', italic = true })
      vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

      vim.api.nvim_set_hl(0, 'Type', { fg = '#7473b1', bold = true, italic = true })
      vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

      vim.api.nvim_set_hl(0, 'String', { fg = '#86e086', italic = true })

      vim.api.nvim_set_hl(0, 'Operator', { fg = '#abb2bf' })
      vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#abb2bf' })
      vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
      vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

      vim.api.nvim_set_hl(0, 'Comment', { fg = '#5c6370', italic = true })

      local current_file_path = vim.fn.stdpath('config') .. '/lua/plugins/dankcolors.lua'
      if not _G._matugen_theme_watcher then
        local uv = vim.uv or vim.loop
        _G._matugen_theme_watcher = uv.new_fs_event()
        _G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
          local new_spec = dofile(current_file_path)
          if new_spec and new_spec[1] and new_spec[1].config then
            new_spec[1].config()
            print('Theme reload')
          end
        end))
      end
    end,
  },
}
