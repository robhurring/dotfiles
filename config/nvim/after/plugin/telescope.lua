local actions = require 'telescope.actions'
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    }
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>r', builtin.oldfiles)
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<m-o>', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep> ") });
end)
