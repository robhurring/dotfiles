return {
  'wellle/targets.vim',
  'tpope/vim-endwise',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-scripts/ReplaceWithRegister',

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { 'coh',            desc = 'Harpoon toggle file' },
      { 'co1',            desc = 'Harpoon toggle slot 1' },
      { 'co2',            desc = 'Harpoon toggle slot 2' },
      { 'co3',            desc = 'Harpoon toggle slot 3' },
      { 'co4',            desc = 'Harpoon toggle slot 4' },
      { '<leader>a',      desc = 'Harpoon picker' },
      { '<localleader>1', desc = 'Harpoon file 1' },
      { '<localleader>2', desc = 'Harpoon file 2' },
      { '<localleader>3', desc = 'Harpoon file 3' },
      { '<localleader>4', desc = 'Harpoon file 4' },
    },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      local function toggle_slot(slot)
        local list = harpoon:list()
        local current = vim.fn.expand('%:.')
        local item_at_slot = list:get(slot)
        if item_at_slot and item_at_slot.value == current then
          list:remove_at(slot)
          vim.notify('Removed from slot ' .. slot, vim.log.levels.INFO)
        else
          list:replace_at(slot)
          vim.notify('Added to slot ' .. slot, vim.log.levels.INFO)
        end
      end

      vim.keymap.set('n', 'coh', function()
        local list = harpoon:list()
        local _, idx = list:get_by_value(vim.fn.expand('%:.'))
        if idx then
          list:remove_at(idx)
          vim.notify('Removed from harpoon', vim.log.levels.INFO)
        else
          list:add()
          vim.notify('Added to harpoon', vim.log.levels.INFO)
        end
      end, { desc = 'Harpoon toggle file' })

      vim.keymap.set('n', 'co1', function() toggle_slot(1) end, { desc = 'Harpoon toggle slot 1' })
      vim.keymap.set('n', 'co2', function() toggle_slot(2) end, { desc = 'Harpoon toggle slot 2' })
      vim.keymap.set('n', 'co3', function() toggle_slot(3) end, { desc = 'Harpoon toggle slot 3' })
      vim.keymap.set('n', 'co4', function() toggle_slot(4) end, { desc = 'Harpoon toggle slot 4' })

      vim.keymap.set('n', '<localleader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon file 1' })
      vim.keymap.set('n', '<localleader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon file 2' })
      vim.keymap.set('n', '<localleader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon file 3' })
      vim.keymap.set('n', '<localleader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon file 4' })

      -- Telescope picker
      vim.keymap.set('n', '<leader>a', function()
        local conf = require('telescope.config').values
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end
        require('telescope.pickers').new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({ results = file_paths }),
          previewer = false,
          sorter = conf.generic_sorter({}),
        }):find()
      end, { desc = 'Harpoon picker' })
    end,

  },

  {
    'chentoast/marks.nvim',
    event = 'BufReadPre',
    config = true,
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' }
    }
  },

  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup({
        options = {
          disable_when_touch = false,
          disable_command_mode = true,
        },
      })
    end
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { '<c-_>', mode = 'n' },
      { '<M-/>', mode = 'n' },
      { '<c-_>', mode = 'x' },
      { '<M-/>', mode = 'x' },
    },
    config = function()
      require('Comment').setup()
    end
  },

  {
    'serenevoid/kiwi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    'jpalardy/vim-slime',
    keys = {
      { '<leader>s',  function() return require('slime_trim').motion() end, expr = true, desc = 'Send motion to tmux (no trailing newline)' },
      { '<leader>ss', '<Plug>SlimeLineSend', desc = 'Send line to tmux' },
      { '<leader>s',  function() require('slime_trim').visual() end, mode = 'x', desc = 'Send selection to tmux (no trailing newline)' },
    },
    init = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_default_config = { socket_name = 'default', target_pane = '{last}' }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
    end,
  },
}
