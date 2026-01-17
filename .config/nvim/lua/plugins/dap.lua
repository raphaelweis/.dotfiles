return {
	"mfussenegger/nvim-dap",
	config = function()
		vim.fn.sign_define("DapBreakpoint", {
			text = " ",
			texthl = "DapBreakpointColor",
			linehl = "",
			numhl = "",
		})

		vim.keymap.set("n", "<leader>b", function()
			require("dap").toggle_breakpoint()
		end)
	end,
}
