return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", {
				text = " ",
				texthl = "DapBreakpointColor",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = " ",
				texthl = "DapBreakpointColor",
				linehl = "",
				numhl = "",
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<leader>do", "<CMD>DapViewToggle<CR>")

			------------------------
			-- Adapter configuration
			------------------------

			-- JS/TS
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { vim.fn.expand("~") .. "/.local/share/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
			if not dap.adapters["node"] then
				dap.adapters["node"] = function(cb, config)
					if config.type == "node" then
						config.type = "pwa-node"
					end
					local nativeAdapter = dap.adapters["pwa-node"]
					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
			}
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		opts = {},
	},
}
