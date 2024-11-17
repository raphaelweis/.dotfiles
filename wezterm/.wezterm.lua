local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config = {
	color_scheme = "One Dark",
	window_frame = {
		font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Medium" }),
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
