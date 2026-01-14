return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"sql",
				"typescript",
				"tsx",
				"vim",
				"xml",
				"yaml",
				"zsh",
				"typst",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
