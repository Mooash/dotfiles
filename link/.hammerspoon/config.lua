local config = {}

-- Hyper Key
config.hyper = {"ctrl", "alt", "cmd", "shift"}

-- Modules to load
config.modules = {
  "launcher",
  "reload",
  "remapper"
}

-- Launch applications
config.launcher = {
  hyper = config.hyper,
  bindings = {
    { key = "I", application = "iTerm" },
    { key = "S", application = "Slack" },
    { key = "B", application = "Firefox" },
    { key = "M", application = "Spotify" },
    { key = "T", application = "Tweetbot" },
    { key = "P", application = "Pocket Casts" },
  }
}

-- Remapper
config.remapper = {
  bindings = {
    { key = "c", modifiers = {"cmd", "alt"}, remap = "c" },
    { key = "v", modifies = { "cmd", "shift", "alt" }, remap = "V"}
  }
}

return config
