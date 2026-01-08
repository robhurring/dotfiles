return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep' }
  },

  'tpope/vim-rhubarb',

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = 'copen',
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        }
      })
    end
  },
}
