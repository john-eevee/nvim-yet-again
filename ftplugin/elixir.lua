local ok = pcall(vim.treesitter.start)
if not ok then
  vim.notify("Call to treesitter start failed")
  vim.bo.syntax = "elixir"
end
