-- nvim-tree and oil configuration
-- Kept separate for extensive configuration
-- See lua/plugins/ui.lua for plugin declarations

require('nvim-tree').setup({
  update_focused_file = {
    enable = true
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  git = {
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = true
    },
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        folder = {
          arrow_closed = "▸",
          arrow_open = "▾",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      }
    }
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
})

require('oil').setup({
  keymaps = {
    ['o'] = 'actions.select',
    ['u'] = 'actions.parent',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
  },
  show_hidden = true
})

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, { noremap = true })
vim.keymap.set('n', '<leader>E', vim.cmd.NvimTreeFindFile, { noremap = true })
vim.keymap.set('n', '-', '<CMD>Oil<CR>')
