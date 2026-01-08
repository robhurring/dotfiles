return {
  'wellle/targets.vim',
  'tpope/vim-endwise',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-scripts/ReplaceWithRegister',

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' }
    }
  },

  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup({
        options = {
          disable_when_touch = false,
          disable_command_mode = true,
        },
      })
    end
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { '<c-_>', mode = 'n' },
      { '<M-/>', mode = 'n' },
      { '<c-_>', mode = 'x' },
      { '<M-/>', mode = 'x' },
    },
    config = function()
      require('Comment').setup()
    end
  },

  {
    'serenevoid/kiwi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
}
