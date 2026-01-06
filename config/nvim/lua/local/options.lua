local cache = vim.env.XDG_CACHE_HOME or vim.fn.expand("~/.cache")

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.clipboard = 'unnamed'
vim.opt.colorcolumn = '101'
vim.opt.conceallevel = 0
vim.opt.concealcursor = 'nc'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars.extends = '»'
vim.opt.listchars.nbsp = '∙'
vim.opt.listchars.precedes = '«'
vim.opt.listchars.tab = '-'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.scrolloff = 3
vim.opt.sessionoptions:remove('help')
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 3
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.tags:append({ './tags', './git/tags' })
vim.opt.termguicolors = true
vim.opt.ttimeoutlen = 100
vim.opt.undofile = true
vim.opt.updatetime = 4000
vim.opt.virtualedit = 'block'
vim.opt.wildmenu = true
vim.opt.wrap = false

vim.opt.undodir = { cache .. '/nvim/undo//' }
vim.opt.backupdir = { cache .. '/nvim/backup//' }
vim.opt.directory = { cache .. '/nvim/swp//' }

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

