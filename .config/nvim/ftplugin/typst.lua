vim.opt.spell = true
vim.opt.spelllang = { "en", "fr" }
vim.opt.textwidth = 80

local MiniDeps = require("mini.deps")
local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({ source = "chomosuke/typst-preview.nvim", checkout = "v1.*" })

	require("typst-preview").setup({
		open_cmd = "firefox --new-window %s",
		port = 8000,
	})
end)
