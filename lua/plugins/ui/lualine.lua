-- ╔══════════════════════════════════════════════════════════════╗
-- ║          LUALINE - RICED STATUS LINE                        ║
-- ║    Aesthetic bubble-style status line with rich info         ║
-- ╚══════════════════════════════════════════════════════════════╝

local colors = {
  blue   = '#89b4fa',
  cyan   = '#89dceb',
  black  = '#181825',
  white  = '#cdd6f4',
  red    = '#f38ba8',
  violet = '#cba6f7',
  grey   = '#313244',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require("lualine").setup({
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      'filename',
      'branch',
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
    },
    lualine_c = {
      '%=', -- [[ middle push ]]
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { "nvim_diagnostic" },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
      },
      {
        function()
          local msg = 'No Active LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = '󰒋 LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      },
    },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = { 'oil', 'trouble', 'lazy' },
})
