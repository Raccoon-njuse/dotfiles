local wezterm = require('wezterm')
local config = {
   font_size = 20,
	font = wezterm.font("Monofur Nerd Font", { weight = "Bold" }),
	color_scheme = "Catppuccin Mocha",
	initial_rows = 30,
	initial_cols = 90,
	use_fancy_tab_bar = true,
	enable_tab_bar = true,
	--tab_bar_at_bottom = true,
	tab_max_width = 18,
	--hide_tab_bar_if_only_one_tab = true,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	integrated_title_button_color = "auto",
	integrated_title_button_style = "MacOsNative",
	--show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 0.9,
	macos_window_background_blur = 70,
	text_background_opacity = 0.9,
	adjust_window_size_when_changing_font_size = false,
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
}

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd", weight = "Bold" }),
	font_size = 14.0,
}


config.colors = {
	tab_bar = {
	  -- The color of the strip that goes along the top of the window
	  -- (does not apply when fancy tab bar is in use)
	  background = '#0b0022',
  
	  -- The active tab is the one that has focus in the window
	  active_tab = {
		-- The color of the background area for the tab
		bg_color = '#7858bc',
		-- The color of the text for the tab
		fg_color = '#c0c0c0',
  
		-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
		-- label shown for this tab.
		-- The default is "Normal"
		intensity = 'Normal',
  
		-- Specify whether you want "None", "Single" or "Double" underline for
		-- label shown for this tab.
		-- The default is "None"
		underline = 'None',
  
		-- Specify whether you want the text to be italic (true) or not (false)
		-- for this tab.  The default is false.
		italic = false,
  
		-- Specify whether you want the text to be rendered with strikethrough (true)
		-- or not for this tab.  The default is false.
		strikethrough = false,
	  },
  
	  -- Inactive tabs are the tabs that do not have focus
	  inactive_tab = {
		bg_color = '#1b1032',
		fg_color = '#808080',
  
		-- The same options that were listed under the `active_tab` section above
		-- can also be used for `inactive_tab`.
	  },
  
	  -- You can configure some alternate styling when the mouse pointer
	  -- moves over inactive tabs
	  inactive_tab_hover = {
		bg_color = '#3b3052',
		fg_color = '#909090',
		italic = true,
  
		-- The same options that were listed under the `active_tab` section above
		-- can also be used for `inactive_tab_hover`.
	  },
  
	  -- The new tab button that let you create new tabs
	  new_tab = {
		bg_color = '#1b1032',
		fg_color = '#808080',
  
		-- The same options that were listed under the `active_tab` section above
		-- can also be used for `new_tab`.
	  },
  
	  -- You can configure some alternate styling when the mouse pointer
	  -- moves over the new tab button
	  new_tab_hover = {
		bg_color = '#3b3052',
		fg_color = '#909090',
		italic = true,
  
		-- The same options that were listed under the `active_tab` section above
		-- can also be used for `new_tab_hover`.
	  },
	},
  }

config.background = {
   {
      source = { File = wezterm.config_dir .. '/backdrops/space.jpg' },
	  height = '100%',
      width = '100%',
      opacity = 0.95,
   },
   {
      source = { Color = '#444444' },
      height = '100%',
      width = '100%',
      opacity = 0.65,
   },
}

require('events.right-status').setup()
--require('events.tab-title').setup()
--require('events.new-tab-button').setup()

-- return Config:init()
--    :append(require('config.appearance'))
--    :append(require('config.bindings'))
--    :append(require('config.domains'))
--    :append(require('config.fonts'))
--    :append(require('config.general')).options
--    --:append(require('config.launch')).options


return config