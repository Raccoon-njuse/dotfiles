local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()
local initial_cols = 120
local initial_rows = 34
local estimated_window_width = 1040
local estimated_window_height = 570

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
  local title = string.format("%d: %s", tab.tab_index + 1, tab_title(tab))
  title = wezterm.truncate_right(title, math.max(0, max_width - 4))

  return {
    { Text = "  " .. title .. "  " },
  }
end)

wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local ratio = 0.4
  local width, height = screen.width * ratio, screen.height * ratio
  local spawn = cmd or {}

  spawn.position = spawn.position or {
    x = (screen.width - width) / 2,
    y = (screen.height - height) / 2,
    origin = "ActiveScreen",
  }

  local _, _, window = mux.spawn_window(spawn)
  window:gui_window():set_inner_size(width, height)
end)

config.font = wezterm.font_with_fallback({
  {
    family = "JetBrainsMono Nerd Font Mono",
    weight = "Regular",
  },
  "Apple Color Emoji",
})
config.font_size = 14.0
config.line_height = 1.08
config.cell_width = 1.0

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.96
config.macos_window_background_blur = 24
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

config.initial_cols = initial_cols
config.initial_rows = initial_rows
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.tab_max_width = 28
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false

config.colors = {
  tab_bar = {
    background = "rgba(12%, 12%, 18%, 90%)",
    active_tab = {
      bg_color = "#cba6f7",
      fg_color = "rgba(12%, 12%, 18%, 0%)",
      intensity = "Bold",
    },
    inactive_tab = {
      fg_color = "#cba6f7",
      bg_color = "rgba(12%, 12%, 18%, 90%)",
      intensity = "Normal",
    },
    inactive_tab_hover = {
      fg_color = "#cba6f7",
      bg_color = "rgba(27%, 28%, 35%, 90%)",
      intensity = "Bold",
    },
    new_tab = {
      fg_color = "#808080",
      bg_color = "#1e1e2e",
    },
  },
}

config.cursor_blink_rate = 500
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true

config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 80,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 120,
}

config.scrollback_lines = 10000
config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"
config.animation_fps = 60
config.max_fps = 120

config.keys = {
  {
    key = "Enter",
    mods = "CMD",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = "N",
    mods = "CMD|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "[",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "]",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(1),
  },
}

return config
