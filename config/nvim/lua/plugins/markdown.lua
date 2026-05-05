return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_preview_options = { disable_sync_scroll = 1 }
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Start markdown preview" })
      vim.keymap.set("n", "<leader>ms", function()
        local opts = vim.g.mkdp_preview_options or {}
        opts.disable_sync_scroll = opts.disable_sync_scroll == 0 and 1 or 0
        vim.g.mkdp_preview_options = opts
        vim.notify("Sync scroll: " .. (opts.disable_sync_scroll == 0 and "on" or "off"))
      end, { desc = "Toggle markdown sync scroll" })

      vim.keymap.set("n", "<leader>mm", function()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local start_line, end_line
        for i = cur, 1, -1 do
          if lines[i] and lines[i]:match("^```mermaid%s*$") then
            start_line = i + 1
            break
          end
          if lines[i] and lines[i]:match("^```%s*$") and i ~= cur then
            break
          end
        end
        if start_line then
          for i = start_line, #lines do
            if lines[i]:match("^```%s*$") then
              end_line = i - 1
              break
            end
          end
        end
        if not (start_line and end_line) then
          vim.notify("Cursor is not inside a ```mermaid block", vim.log.levels.WARN)
          return
        end
        local src = table.concat(vim.list_slice(lines, start_line, end_line), "\n")
        local tmp_in = vim.fn.tempname() .. ".mmd"
        local tmp_out = vim.fn.tempname() .. ".png"
        vim.fn.writefile(vim.split(src, "\n"), tmp_in)
        vim.notify("Rendering mermaid...")
        local env = vim.fn.environ()
        if not env.PUPPETEER_EXECUTABLE_PATH or env.PUPPETEER_EXECUTABLE_PATH == "" then
          local chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
          if vim.uv.fs_stat(chrome) then
            env.PUPPETEER_EXECUTABLE_PATH = chrome
          end
        end
        vim.system(
          { "mmdc", "-i", tmp_in, "-o", tmp_out, "-b", "white", "-s", "3" },
          { text = true, env = env },
          function(res)
            vim.schedule(function()
              if res.code ~= 0 then
                vim.notify("mmdc failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
                return
              end
              local osa = string.format(
                [[set the clipboard to (read (POSIX file "%s") as «class PNGf»)]],
                tmp_out
              )
              local copy = vim.system({ "osascript", "-e", osa }, { text = true }):wait()
              if copy.code == 0 then
                vim.notify("Mermaid PNG copied to clipboard")
              else
                vim.notify("Clipboard copy failed: " .. (copy.stderr or ""), vim.log.levels.ERROR)
              end
            end)
          end
        )
      end, { desc = "Export mermaid block under cursor to clipboard as PNG" })
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
