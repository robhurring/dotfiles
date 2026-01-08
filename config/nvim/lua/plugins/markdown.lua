return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
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
