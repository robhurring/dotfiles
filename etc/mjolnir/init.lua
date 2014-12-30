local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

local resize_size = 50

-- Focusing Windows

hotkey.bind({"cmd", "alt"}, "RIGHT", function()
  local win = window.focusedwindow()
  win:focuswindow_east()
end)

hotkey.bind({"cmd", "alt"}, "LEFT", function()
  local win = window.focusedwindow()
  win:focuswindow_west()
end)

hotkey.bind({"cmd", "alt"}, "UP", function()
  local win = window.focusedwindow()
  win:focuswindow_north()
end)

hotkey.bind({"cmd", "alt"}, "DOWN", function()
  local win = window.focusedwindow()
  win:focuswindow_south()
end)

-- Resizing Windows

hotkey.bind({"cmd", "alt", "ctrl"}, "RIGHT", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.w = f.w + resize_size
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "LEFT", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.w = f.w - resize_size
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "UP", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.h = f.h - resize_size
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "DOWN", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.h = f.h + resize_size
  win:setframe(f)
end)

-- -- Moving Windows

hotkey.bind({"ctrl", "alt"}, "RIGHT", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x + resize_size
  win:setframe(f)
end)

hotkey.bind({"ctrl", "alt"}, "LEFT", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x - resize_size
  win:setframe(f)
end)

hotkey.bind({"ctrl", "alt"}, "UP", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.y = f.y - resize_size
  win:setframe(f)
end)

hotkey.bind({"ctrl", "alt"}, "DOWN", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.y = f.y + resize_size
  win:setframe(f)
end)

-- -- Snapping Windows

-- hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "LEFT", function()
--   local win = window.focusedwindow()
--   win:movetounit({x=0, y=0, w=0.5, h=1.0})
-- end)

-- hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "RIGHT", function()
--   local win = window.focusedwindow()
--   win:movetounit({x=0.5, y=0, w=0.5, h=1.0})
-- end)

-- hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "UP", function()
--   local win = window.focusedwindow()
--   win:movetounit({x=0.5, y=0, w=0.5, h=0.5})
-- end)

-- hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "DOWN", function()
--   local win = window.focusedwindow()
--   win:movetounit({x=0.5, y=0.5, w=0.5, h=0.5})
-- end)
