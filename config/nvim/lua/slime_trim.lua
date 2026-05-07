local M = {}

local function send(text)
  text = text:gsub('[\r\n]+$', '')
  vim.fn['slime#send'](text)
end

local function get_range(start_pos, end_pos, mode)
  local s_line, s_col = start_pos[2], start_pos[3]
  local e_line, e_col = end_pos[2], end_pos[3]
  local lines = vim.fn.getline(s_line, e_line)
  if #lines == 0 then return '' end

  if mode == 'V' or mode == 'line' then
    return table.concat(lines, '\n') .. '\n'
  end

  if mode == 'v' or mode == 'char' then
    if #lines == 1 then
      lines[1] = lines[1]:sub(s_col, e_col)
    else
      lines[1] = lines[1]:sub(s_col)
      lines[#lines] = lines[#lines]:sub(1, e_col)
    end
    return table.concat(lines, '\n')
  end

  return table.concat(lines, '\n')
end

function M.opfunc(motion_type)
  local s = vim.fn.getpos("'[")
  local e = vim.fn.getpos("']")
  local text = get_range(s, e, motion_type)
  send(text)
end

function M.motion()
  vim.go.operatorfunc = "v:lua.require'slime_trim'.opfunc"
  return 'g@'
end

function M.visual()
  local mode = vim.fn.visualmode()
  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")
  local text = get_range(s, e, mode)
  send(text)
end

return M
