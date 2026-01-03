local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

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
end)
