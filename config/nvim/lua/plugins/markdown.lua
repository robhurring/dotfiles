return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_preview_options = { disable_sync_scroll = 1 }
      vim.keymap.set("n", "<leader>ms", function()
        local opts = vim.g.mkdp_preview_options or {}
        opts.disable_sync_scroll = opts.disable_sync_scroll == 0 and 1 or 0
        vim.g.mkdp_preview_options = opts
        vim.notify("Sync scroll: " .. (opts.disable_sync_scroll == 0 and "on" or "off"))
      end, { desc = "Toggle markdown sync scroll" })
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
