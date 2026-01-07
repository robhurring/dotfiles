local M = {}

function M.setup(config)
  local colorscheme = config.colorscheme or "sonokai"
  vim.cmd.colorscheme(colorscheme)
end

return M
