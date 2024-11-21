return {
  'akinsho/toggleterm.nvim', version = "*",
  config = function ()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]], -- Optional: Built-in toggle keybinding
      direction = "horizontal",   -- Choose 'horizontal', 'vertical', or 'float'
    })
  --  vim.keymap.set({"n", "t"}, "<C-t>", "<C-\\><C-n>:ToggleTerm<CR>i", {})
  end
  }
