-- -- RHS screen
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x + (max.w / 2)
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h
--   win:setFrame(f)
-- end)
-- -- LHS screen
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h
--   win:setFrame(f)
-- end)
-- -- Full screen
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Up", function()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     f.x = max.x
--     f.y = max.y
--     f.w = max.w
--     f.h = max.h
--     win:setFrame(f)
-- end)

local alert = require 'hs.alert'

import = require('utils/import')
import.clear_cache()

config = import('config')

function config:get(key_path, default)
  local root = self
  for part in string.gmatch(key_path, "[^\\.]+") do
    root = root[part]
    if root == nil then
      return default
    end
  end
  return root
end

local modules = {}

for _, v in ipairs(config.modules) do
  local module_name = 'modules/' .. v
  local module = import(module_name)

  if type(module.init) == "function" then
    module.init()
  end

  table.insert(modules, module)
end

local buf = {}

if hs.wasLoaded == nil then
  hs.wasLoaded = true
  table.insert(buf, "Hammerspoon loaded: ")
else
  table.insert(buf, "Hammerspoon re-loaded: ")
end

table.insert(buf, #modules .. " modules.")

alert.show(table.concat(buf))

-- Load spoons
hs.loadSpoon("MiroWindowsManager")
hs.loadSpoon("HoldToQuit")

-- HoldToQuit
-- Slightly speedup the default 1 second
spoon.HoldToQuit.duration = 0.2
spoon.HoldToQuit:bindHotkeys(spoon.HoldToQuit.defaultHotkey)

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up    = { config.hyper, "up" },
  right = { config.hyper, "right" },
  down  = { config.hyper, "down" },
  left  = { config.hyper, "left" },
  fullscreen = { config.hyper, "f" }
})

-- Move to other screen
hs.hotkey.bind(config.hyper, "r", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:moveToScreen(screen:next())
end)

-- Lock screen
hs.hotkey.bind(config.hyper, "L", function()
  hs.caffeinate.startScreensaver()
end)

---- Alfred clipboard
--hs.hotkey.bind(config.hyper, "c", function()
--  hs.eventtap.keyStroke({"cmd", "alt"}, "c")
--end)
