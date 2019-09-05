
-- http://github.com/dbmrq/dotfiles/

-- Requires you to keep holding Command + Q for a while before closing an app,
-- so you won't do it accidentally.

-- Replaces apps like CommandQ and SlowQuitApps.


-----------------------------
--  Customization Options  --
-----------------------------

local delay = 0.1 -- In seconds


-------------------------------------------------------------------
--  Don't mess with this part unless you know what you're doing  --
-------------------------------------------------------------------

local killedIt = false
local application = require 'hs.application'
local alert = require 'hs.alert'
local hotkey = require 'hs.hotkey'
local timer = require 'hs.timer'

local function pressedQ()
  killedIt = false
  alert.show("⌘Q")
  timer.usleep(1000000 * delay)
end

local function repeatQ()
  if killedIt then return end
  application.frontmostApplication():kill()
  killedIt = true
  alert.closeAll()
end

local function init_module()
  hotkey.bind('cmd', 'Q', pressedQ, nil, repeatQ)
end

return {
  init = init_module
}
