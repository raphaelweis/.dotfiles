local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = wezterm.config_builder()

config = {
	default_domain = "WSL:Ubuntu",
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	},
	window_close_confirmation = "AlwaysPrompt",
	font = wezterm.font("JetBrainsMonoNL Nerd Font"),
	font_size = 10,
	window_decorations = "RESIZE",
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	keys = {
		{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
		{ key = "0", mods = "ALT", action = act.ActivateTab(9) },
		{ key = "s", mods = "ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "ALT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "ALT|CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "ALT|CTRL", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "ALT|CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "ALT|CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },
		{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "R", mods = "CTRL", action = act.ReloadConfiguration },
		{ key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	},
}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
