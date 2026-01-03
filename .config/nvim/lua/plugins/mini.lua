local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("nvim-mini/mini.nvim")
	add("tpope/vim-fugitive")

	require("mini.basics").setup()
	require("mini.pairs").setup()
	require("mini.statusline").setup()
	require("mini.indentscope").setup({
		draw = {
			delay = 0,
			animation = require("mini.indentscope").gen_animation.none(),
		},
	})
	require("mini.surround").setup()
	require("mini.comment").setup()
	require("mini.indentscope").gen_animation.none()
	require("mini.snippets").setup()
	require("mini.completion").setup({
		lsp_completion = {
			source_func = "omnifunc",
			auto_setup = true,
		},
	})
	require("mini.icons").setup()
	require("mini.pick").setup()
	require("mini.diff").setup({
		view = {
			style = "sign",
			signs = {
				add = "▎",
				change = "▎",
				delete = "▎",
			},
		},
	})
	require("mini.files").setup()

	vim.keymap.set("n", "<leader>e", MiniFiles.open)

	vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files)

	vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live)

	vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers)

	vim.keymap.set("n", "<leader>gd", MiniDiff.toggle_overlay)

	vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>")
end)
