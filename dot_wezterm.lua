local wezterm = require("wezterm")

return {
	-- Use GPU acceleration
	front_end = "WebGpu", -- or "OpenGL" if WebGPU gives issues
	webgpu_power_preference = "HighPerformance",
	animation_fps = 60,
	max_fps = 60,
	------------------------------------------
	---Look and Design
	--------------------------------------------
	window_background_opacity = 0.5, -- for some transparency
	text_background_opacity = 1.0,
	win32_system_backdrop = "Disable",
	window_decorations = "RESIZE",
	window_padding = {

		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	--
	-- macos_window_background_blur = 10,

	----------------------------------------------
	---Font
	----------------------------------------------
	font = wezterm.font("FiraCode Nerd Font"), -- or any dev font
	font_size = 12.03,

	color_scheme = "Belfonte Night", -- favorite scheme

	-- Enable tabs and panes
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	----------------------------------------------------------
	-- Performance tweaks
	-- -----------------------------------------------------
	use_fancy_tab_bar = false,
	enable_scroll_bar = false,
	scrollback_lines = 5000,
	use_dead_keys = false,

	--------------------------------------------------------
	---Cursor
	--------------------------------------------------------
	default_cursor_style = "BlinkingBar",
	cursor_blink_rate = 100,

	----------------------------------------------
	---smoother resizing + repaint
	----------------------------------------------
	adjust_window_size_when_changing_font_size = false,

	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.StartWindowDrag,
		},
	},
	-- Keybind example: open new pane
	leader = {
		key = "Space",
		mods = "CTRL",
		timeout_milliseconds = 1000,
	},
	unix_domains = {
		{
			name = "default",
		},
	},
	keys = {
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		-- Make Ctrl+Backspace send Ctrl+W
		{
			key = "Backspace",
			mods = "CTRL",
			action = wezterm.action.SendString("\x17"), -- Ctrl+W
		},
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({
				confirm = true,
			}),
		},
		{
			key = "1",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "2",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "3",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "4",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({
				flags = "WORKSPACES",
			}),
		},
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Workspace name:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	},

	-- Use PowerShell or whichever shell you want
	default_prog = { "PowerShell.exe", "-NoLogo" },
}
