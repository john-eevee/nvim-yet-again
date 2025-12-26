-- ╔══════════════════════════════════════════════════════════════╗
-- ║         COMMENT.NVIM - SMART COMMENTING                      ║
-- ║    Language-aware code commenting with gc and gb operators   ║
-- ╚══════════════════════════════════════════════════════════════╝

require("Comment").setup({
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  opleader = {
    line = "gc",
    block = "gb",
  },
  extra = {
    above = "gcO",
    below = "gco",
    eol = "gcA",
  },
  mappings = {
    basic = true,
    extra = true,
  },
  post_hook = nil,
})
