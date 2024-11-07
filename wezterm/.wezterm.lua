local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

local merge_tables = function(first_table, second_table)
	for k, v in pairs(second_table) do
		first_table[k] = v
	end
	return first_table
end

local extract_tab_bar_colors_from_theme = function(theme_name)
	local wez_theme = wezterm.color.get_builtin_schemes()[theme_name]
	return {
		window_frame_colors = {
			bg_color = wezterm.color.parse(wez_theme.background):darken(0.2),
			fg_color = wezterm.color.parse(wez_theme.foreground):lighten(0.5),
		},
		tab_bar_colors = {
			background = wezterm.color.parse(wez_theme.background):darken(0.2),
			inactive_tab_edge = wezterm.color.parse(wez_theme.background):darken(0.8),
			active_tab = {
				bg_color = wez_theme.background,
				fg_color = wez_theme.foreground,
			},
			inactive_tab = {
				bg_color = wezterm.color.parse(wez_theme.background):darken(0.2),
				fg_color = wezterm.color.parse(wez_theme.foreground):lighten(0.5),
			},
			inactive_tab_hover = {
				bg_color = wezterm.color.parse(wez_theme.ansi[8]):lighten(0.1),
				fg_color = wezterm.color.parse(wez_theme.brights[1]):lighten(0.4),
			},
			new_tab = {
				bg_color = wezterm.color.parse(wez_theme.background):darken(0.2),
				fg_color = wezterm.color.parse(wez_theme.foreground):lighten(0.5),
			},
			new_tab_hover = {
				bg_color = wezterm.color.parse(wez_theme.ansi[8]):lighten(0.1),
				fg_color = wezterm.color.parse(wez_theme.brights[1]):lighten(0.4),
			},
		},
	}
end

local tab_bar_theme = extract_tab_bar_colors_from_theme("One Light (base16)")

config = {
	color_scheme = "One Light (base16)",
	window_frame = merge_tables({
		font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Medium" }),
	}, tab_bar_theme.window_frame_colors),
	colors = {
		tab_bar = tab_bar_theme.tab_bar_colors,
	},
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
		{ key = "f", mods = "SHIFT|CTRL", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{ key = "Z", mods = "SHIFT|CTRL", action = wezterm.action.TogglePaneZoomState },
		{
			mods = "CTRL|SHIFT",
			key = "i",
			action = wezterm.action_callback(function(guiWindow)
				local thinkerWindow = guiWindow:mux_window()

				-- Configure the thinker workspace
				local homeDir = "/home/raphaelw"
				local thinkerDir = homeDir .. "/D/Thinker-App"

				local mobileTab, _, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/Mobile",
				})
				mobileTab:set_title("Mobile")

				local kafkaTab, zookeeperPane, _ = thinkerWindow:spawn_tab({
					cwd = homeDir .. "/D/kafka38",
				})
				local kafkaServerPane = zookeeperPane:split({
					direction = "Bottom",
					cwd = homeDir .. "/D/kafka38",
					size = 0.5,
				})
				kafkaTab:set_title("Kafka")
				zookeeperPane:send_text("bin/zookeeper-server-start.sh config/zookeeper.properties\n")
				kafkaServerPane:send_text("sleep 20 && bin/kafka-server-start.sh config/server.properties\n")

				local keycloakTab, keycloakDockerPane, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/Keycloak-Auth-Service",
				})
				keycloakTab:set_title("Keycloak")
				keycloakDockerPane:send_text("docker compose up\n")

				local userServiceTab, userServiceServerPane, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/User-Service",
				})
				local userServiceDockerPane = userServiceServerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/User-Service",
					size = 0.666,
				})
				local userServiceConsumerPane = userServiceDockerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/User-Service",
					size = 0.5,
				})
				userServiceTab:set_title("User")
				userServiceServerPane:send_text("sleep 30 && source ./venv/bin/activate && python -m app.main\n")
				userServiceDockerPane:send_text("sleep 30 && docker compose up\n")
				userServiceConsumerPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/user_activity_consumer.py\n"
				)

				local embeddingServiceTab, embeddingServiceServerPane, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/Embedding-Service",
				})
				local embeddingServiceDockerPane = embeddingServiceServerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Embedding-Service",
					size = 0.666,
				})
				local embeddingServiceSchedulerPane = embeddingServiceDockerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Embedding-Service",
					size = 0.5,
				})
				embeddingServiceTab:set_title("Embedding")
				embeddingServiceServerPane:send_text("sleep 30 && source ./venv/bin/activate && python -m app.main\n")
				embeddingServiceDockerPane:send_text("sleep 30 && docker compose up\n")
				embeddingServiceSchedulerPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python -m batch.scheduler\n"
				)

				local quizServiceTab, quizServiceServerPane, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/Quiz-Service",
				})
				local quizServiceLikeProcesserPane = quizServiceServerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Quiz-Service",
					size = 0.80,
				})
				local quizServiceSchedulerPane = quizServiceLikeProcesserPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Quiz-Service",
					size = 0.75,
				})
				local quizServiceViewProcessorCachePane = quizServiceSchedulerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Quiz-Service",
					size = 0.666,
				})
				local quizServiceViewProcessorDbPane = quizServiceViewProcessorCachePane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Quiz-Service",
					size = 0.5,
				})
				quizServiceTab:set_title("Quiz")
				quizServiceServerPane:send_text("sleep 30 && source ./venv/bin/activate && python -m app.main\n")
				quizServiceLikeProcesserPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/like_processor.py\n"
				)
				quizServiceSchedulerPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/scheduler.py\n"
				)
				quizServiceViewProcessorCachePane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/view_processor_cache.py\n"
				)
				quizServiceViewProcessorDbPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/view_processor_db.py\n"
				)

				local feedServiceTab, feedServiceServerPane, _ = thinkerWindow:spawn_tab({
					cwd = thinkerDir .. "/Feed-Service",
				})
				local feedServiceLikeProcesserPane = feedServiceServerPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Feed-Service",
					size = 0.666,
				})
				local feedServiceSchedulerPane = feedServiceLikeProcesserPane:split({
					direction = "Bottom",
					cwd = thinkerDir .. "/Feed-Service",
					size = 0.5,
				})
				feedServiceTab:set_title("Feed")
				feedServiceServerPane:send_text("sleep 30 && source ./venv/bin/activate && python -m app.main\n")
				feedServiceLikeProcesserPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/user_activity_consumer.py\n"
				)
				feedServiceSchedulerPane:send_text(
					"sleep 30 && source ./venv/bin/activate && python batch/scheduler.py\n"
				)
			end),
		},
	},
}

return config
