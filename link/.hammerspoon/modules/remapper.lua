-- Key remapper.  Example config:
--
-- config.remapper = {
--     hyper = {"cmd", "ctrl"},
--     bindings = {
--         { key = "B", modifiers = {"cmd", "alt"}, remap = "c" }
--     }
-- }

local notify = require 'hs.notify'
local application = require 'hs.application'
local hotkey = require 'hs.hotkey'
local eventtap = require 'hs.eventtap'

local function init_module()
  if config.remapper == nil then
    notify.show("Keys has no available config", "", "Set some configs set in config.remapper or unload this module", "")
    return
  end
  
  for _, binding in ipairs(config.remapper.bindings) do
    if binding.key == nil then
      error("Key is missing a key value.")
    end
    
    if binding.remap ~= nil then
      hotkey.bind(config.hyper, binding.key, function()
        eventtap.keyStroke(binding.modifiers, binding.remap)
      end)
    end
  end
end

return {
  init = init_module
}
