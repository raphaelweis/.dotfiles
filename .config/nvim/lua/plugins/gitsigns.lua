return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup()
		vim.keymap.set("n", "<leader>dd", "<CMD>Gitsigns toggle_linehl<CR>")
	end,
}
