local M = {}

M.toggle = function()
  local l_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["location"] == 1 then
      l_exists = true
    end
  end
  if l_exists == true then
    vim.cmd "lclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getloclist(vim.api.nvim_get_current_buf())) then
    vim.cmd "lopen"
  end
end

return M

