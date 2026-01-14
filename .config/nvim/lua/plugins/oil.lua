return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
	opts = {
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["q"] = "actions.close",
		},
	},
}
