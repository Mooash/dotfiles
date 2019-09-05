local hotkey = require 'hs.hotkey'

return {
  init = function()
    hotkey.bind(config:get("reload.mash", {"ctrl", "alt", "cmd", "shift"}), config:get("reload.key", "E"), hs.reload)
  end
}
