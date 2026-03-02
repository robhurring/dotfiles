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

  {
    'jpalardy/vim-slime',
    keys = {
      { '<leader>s',  '<Plug>SlimeMotionSend', desc = 'Send motion to tmux' },
      { '<leader>ss', '<Plug>SlimeLineSend',   desc = 'Send line to tmux' },
      { '<leader>s',  '<Plug>SlimeRegionSend', mode = 'x', desc = 'Send selection to tmux' },
    },
    init = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_default_config = { socket_name = 'default', target_pane = '{last}' }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
    end,
  },
}
