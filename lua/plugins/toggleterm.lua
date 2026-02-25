return {
  "akinsho/toggleterm.nvim",
  version = "*",
  enabled = false,
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
    })
    -- Global helper function to swap terminals in the same window
    _G.switch_toggleterm = function(id)
      -- Check if the current buffer is a toggleterm
      if vim.bo.filetype == "toggleterm" then
        -- Close the split window (hides it, does not kill the process)
        vim.cmd("close")
      end
      -- Open or toggle the requested terminal ID in the panel
      vim.cmd(id .. "ToggleTerm")
    end

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }

      -- Existing navigation maps
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

      -- Splitting terminals side-by-side
      vim.keymap.set("t", "<A-v>", [[<Cmd>wincmd v<CR><Cmd>terminal<CR>]], opts)
      vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd s<CR><Cmd>terminal<CR>]], opts)

      -- Closing and killing terminal panes
      vim.keymap.set("t", "<C-x>", [[<C-\><C-n><Cmd>close<CR>]], opts)
      vim.keymap.set("t", "<C-q>", [[<C-\><C-n><Cmd>bdelete!<CR>]], opts)

      -- New maps: Switching terminal tabs inside the single bottom panel
      vim.keymap.set("t", "<A-1>", [[<C-\><C-n><Cmd>lua switch_toggleterm(1)<CR>]], opts)
      vim.keymap.set("t", "<A-2>", [[<C-\><C-n><Cmd>lua switch_toggleterm(2)<CR>]], opts)
      vim.keymap.set("t", "<A-3>", [[<C-\><C-n><Cmd>lua switch_toggleterm(3)<CR>]], opts)
      vim.keymap.set("t", "<A-4>", [[<C-\><C-n><Cmd>lua switch_toggleterm(4)<CR>]], opts)
    end
    local toggleterm_augroup = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("TermOpen", {
      group = toggleterm_augroup,
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })
  end,
}
