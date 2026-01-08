-- LSP plugin specifications
-- Configuration in after/plugin/lsp.lua and after/plugin/completion.lua

return {
  'folke/lsp-colors.nvim',

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
    "zbirenbaum/copilot.lua",
  },

  {
    "zbirenbaum/copilot-cmp",
  },

  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },
}
