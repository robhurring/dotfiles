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
    show_on_dirs = false
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = true
    },
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = '',
        folder = {
          arrow_closed = "→",
          arrow_open = "↓",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "◌",
          renamed = "R",
          untracked = "?",
          deleted = "✗",
          ignored = "",
        }
      }
    }
  },
  filters = {
    dotfiles = true,
  },
  update_focused_file = {
    enable = true
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
