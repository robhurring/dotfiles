return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = true
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    keys = {
      { '<leader>e', desc = 'Toggle tree' },
      { '<leader>E', desc = 'Find file in tree' }
    }
    -- Configuration in after/plugin/explorer.lua
  },

  {
    'stevearc/oil.nvim',
    keys = { { '-', desc = 'Open oil' } }
    -- Configuration in after/plugin/explorer.lua
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str) return str:sub(1, 1) end,
              -- Terminal mode shares the normal-mode color in most themes;
              -- give it its own, pulled from the theme (warm/orange highlight)
              -- so it tracks the colorscheme like the other modes.
              color = function()
                if vim.fn.mode():find('t') then
                  local u = require('lualine.utils.utils')
                  local bg = u.extract_color_from_hllist('fg', { 'Constant', 'Boolean', 'PreProc' }, '#d19a66')
                  local fg = u.extract_highlight_colors('Normal', 'bg') or '#282c34'
                  return { bg = bg, fg = fg, gui = 'bold' }
                end
              end,
            },
          },
          lualine_b = {
            {
              'diagnostics',
              sources = { 'nvim_lsp', 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
            }
          },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'branch', 'diff' },
          lualine_z = { 'location', 'selectioncount' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {
          'quickfix',
          'nvim-tree'
        }
      }
    end
  },
}
