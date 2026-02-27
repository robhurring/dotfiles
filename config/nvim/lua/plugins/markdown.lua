return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_preview_options = { disable_sync_scroll = 0 }
      local function set_sync(val)
        local opts = vim.g.mkdp_preview_options or {}
        opts.disable_sync_scroll = val
        vim.g.mkdp_preview_options = opts
      end
      vim.api.nvim_create_autocmd("FocusGained", { callback = function() set_sync(0) end })
      vim.api.nvim_create_autocmd("FocusLost",   { callback = function() set_sync(1) end })
    end,
  },

  {
    'weirongxu/plantuml-previewer.vim',
    config = function()
      vim.g["plantuml_previewer#plantuml_jar_path"] = vim.env.PLANTUML_JAR or vim.fn.expand("~/plantuml.jar")
    end,
    dependencies = {
      'tyru/open-browser.vim',
      'aklt/plantuml-syntax'
    }
  },
}
