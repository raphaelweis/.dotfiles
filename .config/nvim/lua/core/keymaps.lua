-- hello
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

vim.keymap.set("n", "td", function()
	local cfg = vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_lines = not cfg.virtual_lines,
		virtual_text = not cfg.virtual_text,
	})
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "=", "<CMD>vertical resize +5<CR>")
vim.keymap.set("n", "-", "<CMD>vertical resize -5<CR>")
vim.keymap.set("n", "+", "<CMD>horizontal resize +2<CR>")
vim.keymap.set("n", "_", "<CMD>horizontal resize -2<CR>")
