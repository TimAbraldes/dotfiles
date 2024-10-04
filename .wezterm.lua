-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.term = 'wezterm'

config.window_background_gradient = {
  colors = { '#300000', '#303000', '#003000', '#003030', '#000030', '#300030' },
  orientation = { Linear = { angle = -20.0 } },
}

-- and finally, return the configuration to wezterm
return config
