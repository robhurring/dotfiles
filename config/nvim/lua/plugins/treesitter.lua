return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },
    config = function()
      require('nvim-treesitter').setup({})

      local ensure = {
        'bash', 'dockerfile', 'go', 'javascript', 'json', 'lua', 'markdown',
        'markdown_inline', 'python', 'ruby', 'tsx', 'typescript', 'vim',
        'vimdoc', 'yaml',
      }
      local installed = require('nvim-treesitter.config').get_installed('parsers')
      local missing = vim.tbl_filter(function(p) return not vim.tbl_contains(installed, p) end, ensure)
      if #missing > 0 then
        require('nvim-treesitter').install(missing)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
      })

      local select = require('nvim-treesitter-textobjects.select').select_textobject
      local map = function(lhs, capture, desc)
        vim.keymap.set({ 'x', 'o' }, lhs, function() select(capture, 'textobjects') end, { desc = desc })
      end
      map('af', '@function.outer', 'Select outer function')
      map('if', '@function.inner', 'Select inner function')
      map('ac', '@class.outer', 'Select outer class')
      map('ic', '@class.inner', 'Select inner class')
      vim.keymap.set({ 'x', 'o' }, 'as', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@scope', 'locals')
      end, { desc = 'Select language scope' })
    end,
  },
}
