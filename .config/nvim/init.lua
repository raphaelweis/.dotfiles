-----------------------------------------------------------------------
-- Bootstrap mini.nvim + mini.deps
-----------------------------------------------------------------------
local minipath = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(minipath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		minipath,
	})
end

require("mini.deps").setup({
	path = { package = vim.fn.stdpath("data") .. "/site" },
})

-----------------------------------------------------------------------
-- Core configuration
-----------------------------------------------------------------------
require("core.options")
require("core.keymaps")
require("core.autocmds")

-----------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------
require("plugins.colorscheme")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.conform")
require("plugins.harpoon")
require("plugins.opencode")
