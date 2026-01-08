return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<C-p>', desc = 'Find files' },
      { '<C-space>', desc = 'Find files' },
      { '<M-o>', desc = 'Find files' },
      { '<leader>r', desc = 'Recent files' },
      { '<leader><leader>', desc = 'Buffers' },
      { '<leader>ps', desc = 'Grep' },
      { '<leader>d', desc = 'Diagnostics' },
    },
    config = function()
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
      vim.keymap.set('n', '<c-space>', builtin.find_files, {})
      vim.keymap.set('n', '<m-o>', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep> ") })
      end)
      vim.keymap.set('n', '<leader>d', builtin.diagnostics)
    end
  },
}
