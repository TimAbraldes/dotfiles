-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.term = 'wezterm'
config.adjust_window_size_when_changing_font_size = false
config.window_background_gradient = {
  colors = { '#000000', '#300000', '#300F00', '#300F00', '#303000', '#303000', '#003000', '#003030', '#003030', '#000030', '#0F0030', '#0F0030', '#300030', '#000000' },
  orientation = { Linear = { angle = -20.0 } },
}

-- and finally, return the configuration to wezterm
return config
