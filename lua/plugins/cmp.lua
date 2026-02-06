return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
    },

    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      snippets = {
        preset = "luasnip",
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}
