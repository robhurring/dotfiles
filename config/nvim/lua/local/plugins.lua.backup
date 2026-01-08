local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- colors
  'sainnhe/edge',
  'sainnhe/sonokai',
  'edeneast/nightfox.nvim',
  { 'embark-theme/vim', name = 'embark' },
  { 'catppuccin/nvim',  name = 'catppuccin' },

  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    keys = {
      { '<leader>e', desc = 'Toggle tree' },
      { '<leader>E', desc = 'Find file in tree' }
    }
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' } }
  },
  'wellle/targets.vim',
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep' }
  },
  'tpope/vim-rhubarb',
  'tpope/vim-endwise',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-scripts/ReplaceWithRegister',
  'folke/lsp-colors.nvim',
  {
    'stevearc/oil.nvim',
    keys = { { '-', desc = 'Open oil' } }
  },
  -- 'github/copilot.vim',

  { "zbirenbaum/copilot.lua" },
  { "zbirenbaum/copilot-cmp" },

  {
    'serenevoid/kiwi.nvim', dependencies = { 'nvim-lua/plenary.nvim' }
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
    }
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  {
    'nvim-lualine/lualine.nvim',
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
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
    }
  },

  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      'theHamsta/nvim-dap-virtual-text',
      'mfussenegger/nvim-dap-python'
    }
  },

  { 'akinsho/git-conflict.nvim', version = "*", config = true },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    'weirongxu/plantuml-previewer.vim',
    config = function()
      vim.g["plantuml_previewer#plantuml_jar_path"] = vim.env.PLANTUML_JAR or vim.fn.expand("~/plantuml.jar")
    end,
    dependencies = {
      'tyru/open-browser.vim',
      'aklt/plantuml-syntax'
    }
  },

})
