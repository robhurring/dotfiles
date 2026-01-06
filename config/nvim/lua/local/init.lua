-- set before plugins so any mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require("local.options")
require("local.plugins")
require("local.keymaps")
require("local.colors").setup({
  colorscheme = "nordfox"
})

local localgroup = vim.api.nvim_create_augroup('local.group', { clear = true })

-- pickup where you left off
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = '*',
  group = localgroup,
  command = 'normal! g`"'
})

vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  pattern = { 'init.lua' },
  group = localgroup,
  command = 'normal mC'
})
