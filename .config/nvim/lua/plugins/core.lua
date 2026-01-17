return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.basics").setup()
			require("mini.comment").setup()
			require("mini.snippets").setup()
			require("mini.notify").setup()
		end,
	},

	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "shortcuts/no-neck-pain.nvim" },
	{ "tpope/vim-fugitive", cmd = "Git", keys = { { "<leader>;", "<CMD>tab Git<CR>", desc = "Git status" } } },
	-- { "christoomey/vim-tmux-navigator", lazy = false },
}
