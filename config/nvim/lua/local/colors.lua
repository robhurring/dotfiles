local M = {}

function M.setup(config)
  local colorscheme = config.colorscheme or "sonokai"

  vim.cmd.colorscheme(colorscheme)

  -- todo: fix conflict colors
  -- vim.api.nvim_set_hl(0, "DiffText", { fg = "#FF0000" })
  -- vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#FF0000" })
  -- vim.api.nvim_set_hl(0, "GitConflictCurrent",
  --   { foreground = "#000000", background = "#ff0000", bold = true, default = true })
  -- vim.api.nvim_set_hl(0, "GitConflictCurrentLabel",
  --   { foreground = "#000000", background = "#ff0000", bold = true, default = true })
end

-- vim.api.nvim_create_autocmd('ColorScheme', {
--   pattern = 'solarized',
--   -- group = ...,
--   callback = function()
--     vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
--       fg = '#555555',
--       ctermfg = 8,
--       force = true
--     })
--   end
-- })

return M
