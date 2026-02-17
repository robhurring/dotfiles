-- AI assistant plugins (Claude Code integration)

return {
  -- Required dependency for claudecode terminal
  { "folke/snacks.nvim", lazy = false },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Accept/deny all diffs commands
      vim.api.nvim_create_user_command("ClaudeCodeDiffAcceptAll", function()
        local diff = require("claudecode.diff")
        for tab_name, _ in pairs(diff._get_active_diffs() or {}) do
          diff.accept_current_diff()
        end
      end, { desc = "Accept all Claude diffs" })

      vim.api.nvim_create_user_command("ClaudeCodeDiffDenyAll", function()
        local diff = require("claudecode.diff")
        for tab_name, _ in pairs(diff._get_active_diffs() or {}) do
          diff.deny_current_diff()
        end
      end, { desc = "Deny all Claude diffs" })
    end,
    keys = {
      -- Cursor/Windsurf-style keybindings
      { "<C-S-l>", "<cmd>ClaudeCodeAdd %<cr>", mode = "n", desc = "Add buffer to Claude" },
      { "<C-S-l>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
      { "<C-S-k>", "<cmd>ClaudeCodeFocus<cr>", mode = { "n", "v", "i" }, desc = "Focus Claude" },

      -- Localleader mappings (,c prefix for Claude)
      { "<localleader>c", nil, desc = "Claude Code" },
      { "<localleader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<localleader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<localleader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer to Claude" },
      { "<localleader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
      { "<localleader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume conversation" },
      { "<localleader>co", "<cmd>ClaudeCode --continue<cr>", desc = "Continue conversation" },

      -- Diff handling
      { "<localleader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<localleader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      { "<localleader>cA", "<cmd>ClaudeCodeDiffAcceptAll<cr>", desc = "Accept ALL diffs" },
      { "<localleader>cD", "<cmd>ClaudeCodeDiffDenyAll<cr>", desc = "Deny ALL diffs" },

      -- File tree integration
      {
        "<localleader>cs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file to Claude",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
    },
    opts = {
      -- Start server automatically when opening Neovim
      auto_start = true,

      -- Terminal configuration
      terminal = {
        split_side = "right",
        split_width_percentage = 0.40,
        provider = "snacks",
      },

      -- Track visual selections for context
      track_selection = true,

      -- Diff options
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
      },
    },
  },
}
