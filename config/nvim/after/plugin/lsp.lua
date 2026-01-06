local telescope_builtin = require('telescope.builtin')
local lsp_group = vim.api.nvim_create_augroup('local.lsp.group', { clear = true })

-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = lsp_group,
  callback = function(event)
    local opts = { buffer = event.buf }

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', telescope_builtin.lsp_definitions, opts)
    vim.keymap.set('n', '<c-]>', telescope_builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)

    vim.keymap.set('n', '<leader>vr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '<tab>', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<F6>', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end, opts)
  end
})

-- Capabilities for completion
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason setup
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'gopls', 'jedi_language_server' },
  automatic_installation = true,
})

-- Configure LSP servers using the new vim.lsp.config API (Neovim 0.11+)
vim.lsp.config('lua_ls', {
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  }
})

vim.lsp.config('gopls', {
  capabilities = lsp_capabilities,
})

vim.lsp.config('jedi_language_server', {
  capabilities = lsp_capabilities,
})

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
