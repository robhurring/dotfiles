local M = {}

local function strip_todo_prefix(line)
  -- Strip markdown checkbox: "- [ ] ", "* [ ] ", "- [x] ", etc.
  line = line:gsub("^%s*[-*]%s+%[.%]%s+", "")
  -- Strip plain list markers: "- ", "* "
  line = line:gsub("^%s*[-*]%s+", "")
  return vim.trim(line)
end

local function get_text(opts)
  if opts.range > 0 then
    local lines = vim.fn.getline(opts.line1, opts.line2)
    return table.concat(lines, " ")
  else
    return vim.api.nvim_get_current_line()
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Todo", function(opts)
    local raw = get_text(opts)
    local text = strip_todo_prefix(raw)

    local task = vim.fn.input("Today: ", text)
    if vim.trim(task) == "" then
      return
    end

    local result = vim.fn.system({ "today", "add", task })
    local ok = vim.v.shell_error == 0

    if ok then
      vim.notify("Todoist: added \"" .. task .. "\"", vim.log.levels.INFO)
    else
      vim.notify("Todoist: failed to add task\n" .. result, vim.log.levels.ERROR)
    end
  end, { range = true, desc = "Add current line/selection to Todoist via today add" })
end

return M
