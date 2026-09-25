-- Obsidian vault integration: notes, links, tags and its own in-process LSP
-- (completion for [[note references]], #tags and [^footnotes]).
return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- latest release
    -- Eager on purpose: obsidian.nvim wires its LSP and buffer keymaps from a
    -- FileType autocmd, so loading it on `ft = "markdown"`/`keys` would miss
    -- whichever markdown buffer triggered the load.
    lazy = false,
    opts = {
      legacy_commands = false, -- only `:Obsidian <subcommand>` + LSP code actions
      workspaces = {
        { name = "notes", path = "~/Notes" },
      },
      picker = { name = "telescope.nvim" },
      -- Vault filenames are kebab-case (abstraction-ban.md), so name new notes
      -- from their title instead of the default timestamp+random zettel id.
      -- Deferred require: this spec is read before the plugin is on the rtp.
      note_id_func = function(...)
        return require("obsidian.builtin").title_id(...)
      end,
    },
    keys = {
      { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
      { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
      { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
      { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
      { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Note backlinks" },
      { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Note links" },
      { "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open note in Obsidian" },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- The concealed UI (links, checkboxes, bullets) needs conceallevel 1-2.
      -- Buffer-local, so it does not leak into other filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },
}
