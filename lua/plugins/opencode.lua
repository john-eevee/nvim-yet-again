local ok, opencode = pcall(require, 'opencode')
if not ok then
  return
end
---@diagnostic disable-next-line: undefined-global
vim.g.opencode_opts = {
  provider = {
    enabled = "wezterm",
    wezterm = {
      direction = "right",
      percent = 20
    }
  }
}
---@diagnostic disable-next-line: undefined-global
vim.o.autoread = true
---@diagnostic disable-next-line: undefined-global
vim.keymap.set('n', '<leader>oo', function()
  opencode.select()
end)
