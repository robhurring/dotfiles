-- set before plugins so any mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require("local.options")
require("local.plugins")
require("local.keymaps")
require("local.colors").setup({
  colorscheme = "jellybeans"
})

local localgroup = vim.api.nvim_create_augroup('local.group', { clear = true })

-- pickup where you left off
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = '*',
  group = localgroup,
  command = 'normal! g`"'
})

-- Reload files changed on disk (e.g. Claude editing the buffer in a side
-- pane). autoread only permits reloads; checktime is what triggers them.
-- These events fire when you return to a code window, so it reloads on focus.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  group = localgroup,
  callback = function()
    if vim.fn.mode() ~= 'c' and vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- Notify when a buffer was reloaded from disk underneath us.
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = localgroup,
  callback = function()
    vim.notify('Buffer reloaded from disk', vim.log.levels.INFO)
  end,
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

require("local.today").setup()
