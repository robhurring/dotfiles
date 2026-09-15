return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<C-p>', desc = 'Find files' },
      { '<C-space>', desc = 'Find files' },
      { '<M-o>', desc = 'Find files' },
      { '<leader>r', desc = 'Recent files' },
      { '<leader><leader>', desc = 'Buffers' },
      { '<leader>ps', desc = 'Grep' },
      { '<leader>d', desc = 'Diagnostics' },
    },
    config = function()
      local actions = require 'telescope.actions'
      local previewers = require 'telescope.previewers'
      local preview_utils = require 'telescope.previewers.utils'

      local function binary_preview(filepath, bufnr, opts)
        local ok, image = pcall(require, 'snacks.image')
        if not ok or image.config.enabled == false or not image.supports_file(filepath) then
          preview_utils.set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed', opts.preview.msg_bg_fillchar)
          return
        end

        local extension = vim.fn.fnamemodify(filepath, ':e'):lower()
        if extension ~= 'png' and vim.fn.executable('magick') == 0 then
          preview_utils.set_preview_message(bufnr, opts.winid, 'Image preview requires ImageMagick', opts.preview.msg_bg_fillchar)
          return
        end

        image.buf.attach(bufnr, { src = filepath })
      end

      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              preview_cutoff = 0,
              preview_height = 0.6,
            },
          },
          preview = {
            treesitter = false,
            mime_hook = binary_preview,
          },
          buffer_previewer_maker = previewers.buffer_previewer_maker,
          mappings = {
            i = {
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
            },
          }
        }
      }

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>r', builtin.oldfiles)
      vim.keymap.set('n', '<c-p>', builtin.find_files, {})
      vim.keymap.set('n', '<c-space>', builtin.find_files, {})
      vim.keymap.set('n', '<m-o>', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep> ") })
      end)
      vim.keymap.set('n', '<leader>d', builtin.diagnostics)
    end
  },
}
