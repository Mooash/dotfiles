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
local hyper = {"ctrl", "alt", "cmd", "shift"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})

-- Move to other screen
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "r", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:moveToScreen(screen:next())
end)
