local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<c-m>", function() harpoon:list():add() end)
vim.keymap.set("n", "<c-m>", function() harpoon:list():add() end)
vim.keymap.set("n", "<c-s-a>", function() harpoon:list():remove() end)
vim.keymap.set("n", "1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "4", function() harpoon:list():select(4) end)

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<c-h>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
