return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = { 'prettier' },
      })

      require('conform').setup({
        formatters_by_ft = {
          css = { 'prettier' },
          graphql = { 'prettier' },
          html = { 'prettier' },
          javascript = { 'prettier' },
          javascriptreact = { 'prettier' },
          json = { 'prettier' },
          jsonc = { 'prettier' },
          less = { 'prettier' },
          markdown = { 'prettier' },
          markdown_mdx = { 'prettier' },
          scss = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          vue = { 'prettier' },
          yaml = { 'prettier' },
        },
      })
    end,
  },
}
