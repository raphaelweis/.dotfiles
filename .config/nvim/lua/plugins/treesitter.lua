return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parsers = {
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
			}

			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = parsers,
				callback = function()
					vim.treesitter.start()
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
