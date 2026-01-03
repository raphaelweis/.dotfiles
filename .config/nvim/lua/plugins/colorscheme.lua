local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("ellisonleao/gruvbox.nvim")
	require("gruvbox").setup({
		contrast = "hard",
		italic = { strings = false },
	})
	vim.cmd.colorscheme("gruvbox")
end)
