require('git-conflict').setup({
  default_mappings = true,     -- disable buffer local mapping created by this plugin
  default_commands = true,     -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  list_opener = 'copen',       -- command or function to open the conflicts list
  highlights = {               -- They must have background color, otherwise the default color will be used
    incoming = 'DiffAdd',
    current = 'DiffText',
  }
})

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'GitConflictDetected',
--   callback = function()
--   end
-- })

-- conflict-marker.vim overrides
-- vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
-- vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#ee5049" })
-- vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
-- vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
-- vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

-- default mappings
-- vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
-- vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
-- vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
-- vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
-- vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
-- vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
