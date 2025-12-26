-- ╔══════════════════════════════════════════════════════════════╗
-- ║        NVIM-AUTOPAIRS - AUTO BRACKET PAIRING                 ║
-- ║    Automatic bracket, quote, and pair completion              ║
-- ╚══════════════════════════════════════════════════════════════╝

require("nvim-autopairs").setup({
  check_ts = true,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- Integrate with cmp for smart pairing
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
