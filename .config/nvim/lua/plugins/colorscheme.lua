return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		local colors = require("gruvbox").palette

		require("gruvbox").setup({
			contrast = "hard",
			italic = { strings = false },
			overrides = {
				SignColumn = { bg = "NONE" },
				DiagnosticSignError = { bg = "NONE", fg = colors.bright_red },
				DiagnosticSignWarn = { bg = "NONE", fg = colors.bright_yellow },
				DiagnosticSignHint = { bg = "NONE", fg = colors.bright_aqua },
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
