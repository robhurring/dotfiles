local file = vim.api.nvim_buf_get_name(0)
local dir = vim.fs.dirname(file)
local behave_suite = false
while dir and dir ~= vim.fs.dirname(dir) do
  if vim.fs.basename(dir) == 'features' and vim.fn.filereadable(vim.fs.dirname(dir) .. '/environment.py') == 1 then
    behave_suite = true
    break
  end
  dir = vim.fs.dirname(dir)
end
if not behave_suite then
  return
end

local root = vim.fs.root(0, { 'pyproject.toml', 'behave.ini', '.git' }) or vim.fn.getcwd()

vim.keymap.set('n', '<localleader>tt', function()
  local scenario_line
  for line = vim.api.nvim_win_get_cursor(0)[1], 1, -1 do
    local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    if text:match('^%s*Scenario:%s*%S') or text:match('^%s*Scenario Outline:%s*%S') then
      scenario_line = line
      break
    end
  end
  if not scenario_line then
    vim.notify('No Behave scenario above the cursor', vim.log.levels.WARN)
    return
  end

  local behave = root .. '/.venv/bin/behave'
  if vim.fn.executable(behave) ~= 1 then
    behave = vim.fn.exepath('behave')
    if behave == '' then
      vim.notify('Behave not found in .venv or PATH', vim.log.levels.ERROR)
      return
    end
  end

  vim.cmd('botright split')
  vim.cmd('resize 15')
  vim.fn.termopen({ behave, file .. ':' .. scenario_line, '-v', '--color', 'auto' }, { cwd = root })
  vim.cmd('startinsert')
end, { buffer = true, desc = 'Run Behave scenario under cursor' })
