-- set before plugins so any mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require("local.options")
require("local.plugins")
require("local.keymaps")
require("local.colors").setup({
  colorscheme = "jb"
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

-- highlight active split
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = localgroup,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  group = localgroup,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
