return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local smart_tab = require("utils.smart-tab-jumper")

    cmp.setup({

      -- ... Your other configuration ...

      -- Auto-select first entry
      completion = {
        completeopt = "menu,menuone,noselect",
      },

      -- Snippet configuration
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {

        -- ... Your other mappings ...
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = smart_tab.create_cmp_mapping(cmp, luasnip),

        ["<S-Tab>"] = smart_tab.create_shift_tab_mapping(cmp, luasnip),

        -- ... Your other mappings ...
      },

      -- ... Your other configuration ...
    })
  end,
}
