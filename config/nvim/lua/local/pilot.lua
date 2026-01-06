local copilot = require('copilot.suggestion')

local default_config = {
  -- copilot-first experience vs cmp-first experience
  enabled = false
  --@todo move the crazy S/TAB cmp mappings here to avoid conflicts
}

local mod = {
  config = default_config
}

function mod.enabled()
  return mod.config.enabled
end

function mod.toggle()
  mod.config.enabled = not mod.config.enabled
  copilot.toggle_auto_trigger()
  print("pilot is now " .. (mod.config.enabled and "enabled" or "disabled"))
end

function mod.setup(opts)
  local config = vim.tbl_deep_extend("force", default_config, opts or {})
  mod.config = config

  local copilot_config = {
    suggestion = {
      auto_trigger = config.enabled,
      keymap = {
        -- accept = "<tab>"
      }
    }
  }

  require("copilot").setup(copilot_config)

  return mod
end

return mod
