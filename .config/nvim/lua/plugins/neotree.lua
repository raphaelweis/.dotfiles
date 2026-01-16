return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				window = {
					width = 60,
				},
			})

			vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>")
		end,
	},
}
