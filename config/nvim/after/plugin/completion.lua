-- co/pilot setup
local pilot = require("local.pilot").setup({
  enabled = false,
})
require("copilot_cmp").setup()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local copilot = require('copilot.suggestion')

-- Helper function to check if we have words before cursor
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.g.cmp_enabled = vim.g.cmp_enabled or true

cmp.setup({
  enabled = function()
    return not pilot.enabled()
  end,
  completion = {
    -- autocomplete = false,
  },
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.exact,
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<c-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if pilot.enabled() then
        if copilot.is_visible() then
          copilot.accept()
        else
          fallback()
        end

        return
      end

      local entry = cmp.get_selected_entry()

      if cmp.visible() then
        if not entry then
          cmp.select_next_item({ behavior = cmp_select })
          cmp.confirm()
        else
          cmp.confirm()
        end
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if pilot.enabled() then
        if copilot.is_visible() then
          copilot.prev()
        else
          fallback()
        end
        return
      end

      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  experimental = {
    ghost_text = true,
    native_menu = false
  },
})

-- Cmdline completion for :
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
