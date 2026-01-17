return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.fn.sign_define("DapBreakpoint", {
				text = " ",
				texthl = "DapBreakpointColor",
				linehl = "",
				numhl = "",
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<leader>do", "<CMD>DapViewToggle<CR>")

			-- Adapter configuration
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { vim.fn.expand("~") .. "/.local/share/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}

			require("dap").configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			require("dap").configurations.typescript = {
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
