vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end
vim.g.colors_name = 'jellybeans'

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local p = {
  -- Base backgrounds (JetBrains Islands Dark)
  bg           = '#1e1f22',
  bg_dark      = '#16171a',
  bg_float     = '#2b2d30',
  bg_highlight = '#26282e',
  bg_visual    = '#2a2828',
  bg_search    = '#3a2e1a',

  -- Foregrounds
  fg           = '#bcbec4',
  fg_dark      = '#9da0a6',
  fg_dim       = '#6e7178',
  fg_subtle    = '#43454a',

  -- Cursor
  cursor       = '#ffa460',

  -- Semantic colors
  keyword      = '#cf8e6d',   -- JB Islands orange
  keyword_alt  = '#e8c08a',   -- lighter orange for storage/async
  string       = '#6aab73',   -- JB Islands green
  string_special = '#8ecf9c', -- brighter green for escapes / f-string {}
  number       = '#2aacb8',   -- JB Islands teal/cyan
  func         = '#56a8f5',   -- JB Islands blue (function calls)
  func_def     = '#56a8f5',   -- same blue for declarations (JB doesn't distinguish strongly)
  type         = '#6aab73',   -- GREEN — class names match strings in Islands Dark
  type_builtin = '#2aacb8',   -- TEAL — built-in types (str, int, list) match builtins
  field        = '#e1c0fa',   -- purple kept for instance vars (self.name)
  constant     = '#e8c08a',   -- orange-warm for True/False/None/UPPER_CASE
  builtin_fn   = '#2aacb8',   -- teal for len/print/getattr/str()
  comment      = '#7a7e85',   -- JB Islands comment grey
  decorator    = '#cf8e6d',   -- orange, same as keyword
  operator     = '#bcbec4',   -- neutral default
  punct        = '#6e7178',   -- subdued delimiters
  error        = '#e17373',
  warning      = '#cf8e6d',   -- match keyword orange
  info         = '#56a8f5',   -- blue
  hint         = '#6aab73',   -- green
  param        = '#c8b89a',   -- warm salmon for kwargs/params

  -- Git/Diff
  diff_add_bg    = '#1a2a1a',
  diff_del_bg    = '#2a1a1a',
  diff_change_bg = '#1a1a2a',
  diff_text_bg   = '#0d2a0d',
  sign_add       = '#94b978',
  sign_change    = '#96bddb',
  sign_delete    = '#e17373',
}

-- ─── Core Vim Groups ─────────────────────────────────────────────────────────

hi('Normal',          { fg = p.fg,       bg = p.bg })
hi('NormalNC',        { fg = p.fg_dark,  bg = p.bg_dark })
hi('Comment',         { fg = p.comment,  italic = true })
hi('Constant',        { fg = p.constant })
hi('String',          { fg = p.string })
hi('Character',       { fg = p.string })
hi('Number',          { fg = p.number })
hi('Boolean',         { fg = p.constant })
hi('Float',           { fg = p.number })
hi('Identifier',      { fg = p.fg })
hi('Function',        { fg = p.func })
hi('Statement',       { fg = p.keyword })
hi('Conditional',     { fg = p.keyword })
hi('Repeat',          { fg = p.keyword })
hi('Label',           { fg = p.keyword })
hi('Operator',        { fg = p.operator })
hi('Keyword',         { fg = p.keyword })
hi('Exception',       { fg = p.keyword,  bold = true })
hi('PreProc',         { fg = p.keyword_alt })
hi('Include',         { fg = p.keyword })
hi('Define',          { fg = p.keyword_alt })
hi('Macro',           { fg = p.keyword_alt })
hi('Type',            { fg = p.type })
hi('StorageClass',    { fg = p.keyword_alt })
hi('Structure',       { fg = p.type })
hi('Typedef',         { fg = p.type })
hi('Special',         { fg = p.string_special })
hi('SpecialChar',     { fg = p.string_special })
hi('Delimiter',       { fg = p.punct })
hi('SpecialComment',  { fg = p.comment, bold = true })
hi('Error',           { fg = p.error })
hi('Todo',            { fg = p.keyword, bold = true, reverse = true })
hi('Underlined',      { fg = p.func, underline = true })

-- ─── UI Groups ────────────────────────────────────────────────────────────────

hi('LineNr',          { fg = p.fg_subtle })
hi('CursorLine',      { bg = p.bg_highlight })
hi('CursorLineNr',    { fg = p.fg_dim, bold = true })
hi('SignColumn',      { bg = p.bg })
hi('ColorColumn',     { bg = p.bg_highlight })
hi('VertSplit',       { fg = p.fg_subtle })
hi('WinSeparator',    { fg = p.fg_subtle })
hi('StatusLine',      { fg = p.fg_dark, bg = p.bg_dark })
hi('StatusLineNC',    { fg = p.fg_subtle, bg = p.bg_dark })
hi('TabLine',         { fg = p.fg_dim, bg = p.bg_dark })
hi('TabLineSel',      { fg = p.fg, bg = p.bg_highlight, bold = true })
hi('TabLineFill',     { bg = p.bg_dark })
hi('Visual',          { bg = p.bg_visual })
hi('Search',          { fg = p.fg, bg = p.bg_search, bold = true })
hi('IncSearch',       { fg = p.bg, bg = p.cursor, bold = true })
hi('Pmenu',           { fg = p.fg_dark, bg = p.bg_float })
hi('PmenuSel',        { fg = p.fg, bg = p.bg_highlight, bold = true })
hi('PmenuSbar',       { bg = p.bg_dark })
hi('PmenuThumb',      { bg = p.bg_visual })
hi('NormalFloat',     { fg = p.fg, bg = p.bg_float })
hi('FloatBorder',     { fg = p.fg_subtle, bg = p.bg_float })
hi('FoldColumn',      { fg = p.fg_subtle, bg = p.bg })
hi('Folded',          { fg = p.fg_dim, bg = p.bg_dark, italic = true })
hi('EndOfBuffer',     { fg = p.fg_subtle })
hi('NonText',         { fg = p.fg_subtle })
hi('MatchParen',      { fg = p.cursor, bold = true })
hi('SpecialKey',      { fg = p.fg_subtle })
hi('Whitespace',      { fg = p.fg_subtle })

-- ─── Treesitter Groups ────────────────────────────────────────────────────────

-- Variables & Parameters
hi('@variable',               { fg = p.fg })
hi('@variable.builtin',       { fg = p.keyword_alt })
hi('@variable.parameter',     { fg = p.param })
hi('@variable.member',        { fg = p.field })

-- Constants
hi('@constant',               { fg = p.constant })
hi('@constant.builtin',       { fg = p.constant, bold = true })
hi('@constant.macro',         { fg = p.constant })

-- Strings
hi('@string',                 { fg = p.string })
hi('@string.escape',          { fg = p.string_special })
hi('@string.special',         { fg = p.string_special })
hi('@string.regex',           { fg = p.string_special })
hi('@character',              { fg = p.string })
hi('@character.special',      { fg = p.string_special })

-- Numbers / Booleans
hi('@number',                 { fg = p.number })
hi('@number.float',           { fg = p.number })
hi('@boolean',                { fg = p.constant, bold = true })

-- Functions
hi('@function',               { fg = p.func_def })
hi('@function.builtin',       { fg = p.builtin_fn })
hi('@function.call',          { fg = p.fg })         -- user fn calls: default text
hi('@function.macro',         { fg = p.keyword_alt })
hi('@function.method',        { fg = p.func_def })
hi('@function.method.call',   { fg = p.fg })         -- method calls: default text
hi('@constructor',            { fg = p.type })

-- Keywords
hi('@keyword',                { fg = p.keyword })
hi('@keyword.function',       { fg = p.keyword })
hi('@keyword.operator',       { fg = p.keyword })
hi('@keyword.import',         { fg = p.keyword })
hi('@keyword.storage',        { fg = p.keyword_alt })
hi('@keyword.return',         { fg = p.keyword })
hi('@keyword.exception',      { fg = p.keyword, bold = true })
hi('@keyword.conditional',    { fg = p.keyword })
hi('@keyword.repeat',         { fg = p.keyword })
hi('@keyword.directive',      { fg = p.keyword_alt })
hi('@keyword.coroutine',      { fg = p.keyword_alt })

-- Types
hi('@type',                   { fg = p.type })
hi('@type.builtin',           { fg = p.type_builtin })
hi('@type.qualifier',         { fg = p.keyword_alt })
hi('@type.definition',        { fg = p.type, bold = true })

-- Operators / Punctuation
hi('@operator',               { fg = p.operator })
hi('@punctuation.delimiter',  { fg = p.punct })
hi('@punctuation.bracket',    { fg = p.punct })
hi('@punctuation.special',    { fg = p.string_special })

-- Modules
hi('@module',                 { fg = p.fg_dark })
hi('@namespace',              { fg = p.fg_dark })
hi('@label',                  { fg = p.keyword_alt })

-- Attributes / Decorators
hi('@attribute',              { fg = p.decorator, italic = true })
hi('@attribute.builtin',      { fg = p.decorator, italic = true })

-- Markup (Markdown)
hi('@markup.heading.1',       { fg = p.func_def, bold = true })
hi('@markup.heading.2',       { fg = p.func, bold = true })
hi('@markup.heading.3',       { fg = p.func_def })
hi('@markup.heading.4',       { fg = p.func_def })
hi('@markup.heading.5',       { fg = p.func_def })
hi('@markup.heading.6',       { fg = p.func_def })
hi('@markup.bold',            { fg = p.fg, bold = true })
hi('@markup.italic',          { fg = p.fg, italic = true })
hi('@markup.strikethrough',   { fg = p.fg_dim, strikethrough = true })
hi('@markup.raw',             { fg = p.string })
hi('@markup.raw.block',       { fg = p.fg })
hi('@markup.link',            { fg = p.func, underline = true })
hi('@markup.link.url',        { fg = p.number, underline = true })
hi('@markup.list',            { fg = p.keyword })
hi('@markup.list.checked',    { fg = p.string })
hi('@markup.list.unchecked',  { fg = p.fg_dim })
hi('@markup.quote',           { fg = p.comment, italic = true })

-- HTML / JSX Tags
hi('@tag',                    { fg = p.type })
hi('@tag.attribute',          { fg = p.param })
hi('@tag.delimiter',          { fg = p.punct })

-- ─── LSP Semantic Highlights ──────────────────────────────────────────────────

hi('@lsp.type.class',         { fg = p.type })
hi('@lsp.type.function',      { fg = p.func_def })
hi('@lsp.type.method',        { fg = p.func_def })
hi('@lsp.type.parameter',     { fg = p.param })
hi('@lsp.type.variable',      { fg = p.fg })
hi('@lsp.type.property',      { fg = p.field })
hi('@lsp.type.keyword',       { fg = p.keyword })
hi('@lsp.type.namespace',     { fg = p.fg_dark })
hi('@lsp.type.type',          { fg = p.type })
hi('@lsp.type.interface',     { fg = p.type, italic = true })
hi('@lsp.type.enum',          { fg = p.type })
hi('@lsp.type.enumMember',    { fg = p.constant })
hi('@lsp.type.decorator',     { fg = p.decorator, italic = true })
hi('@lsp.type.comment',       { fg = p.comment, italic = true })
hi('@lsp.mod.deprecated',     { fg = p.fg_dim, strikethrough = true })
hi('@lsp.mod.readonly',       { fg = p.constant })
hi('@lsp.mod.static',         { fg = p.func_def, bold = true })

-- ─── Diagnostics ─────────────────────────────────────────────────────────────

hi('DiagnosticError',              { fg = p.error })
hi('DiagnosticWarn',               { fg = p.warning })
hi('DiagnosticInfo',               { fg = p.info })
hi('DiagnosticHint',               { fg = p.hint })
hi('DiagnosticSignError',          { fg = p.error })
hi('DiagnosticSignWarn',           { fg = p.warning })
hi('DiagnosticSignInfo',           { fg = p.info })
hi('DiagnosticSignHint',           { fg = p.hint })
hi('DiagnosticVirtualTextError',   { fg = p.error,   bg = p.bg_highlight })
hi('DiagnosticVirtualTextWarn',    { fg = p.warning, bg = p.bg_highlight })
hi('DiagnosticVirtualTextInfo',    { fg = p.info,    bg = p.bg_highlight })
hi('DiagnosticVirtualTextHint',    { fg = p.hint,    bg = p.bg_highlight })
hi('DiagnosticUnderlineError',     { underline = true, sp = p.error })
hi('DiagnosticUnderlineWarn',      { underline = true, sp = p.warning })
hi('DiagnosticUnderlineInfo',      { underline = true, sp = p.info })
hi('DiagnosticUnderlineHint',      { underline = true, sp = p.hint })

-- ─── Git / Diff ───────────────────────────────────────────────────────────────

hi('DiffAdd',     { bg = p.diff_add_bg })
hi('DiffDelete',  { bg = p.diff_del_bg })
hi('DiffChange',  { bg = p.diff_change_bg })
hi('DiffText',    { bg = p.diff_text_bg })

-- GitSigns
hi('GitSignsAdd',    { fg = p.sign_add })
hi('GitSignsChange', { fg = p.sign_change })
hi('GitSignsDelete', { fg = p.sign_delete })

-- ─── Plugins ──────────────────────────────────────────────────────────────────

-- Telescope
hi('TelescopeNormal',        { fg = p.fg,       bg = p.bg_float })
hi('TelescopeBorder',        { fg = p.fg_subtle, bg = p.bg_float })
hi('TelescopePromptNormal',  { fg = p.fg,       bg = p.bg_highlight })
hi('TelescopePromptBorder',  { fg = p.fg_subtle })
hi('TelescopeSelection',     { bg = p.bg_visual })
hi('TelescopeMatching',      { fg = p.number, bold = true })

-- nvim-tree
hi('NvimTreeNormal',            { fg = p.fg_dark,  bg = p.bg_float })
hi('NvimTreeRootFolder',        { fg = p.keyword,  bold = true })
hi('NvimTreeFolderName',        { fg = p.func })
hi('NvimTreeOpenedFolderName',  { fg = p.func })
hi('NvimTreeGitNew',            { fg = p.sign_add })
hi('NvimTreeGitDirty',          { fg = p.sign_change })
hi('NvimTreeGitDeleted',        { fg = p.sign_delete })

-- LspInlayHint
hi('LspInlayHint', { fg = p.param, bg = p.bg_highlight, italic = true })
