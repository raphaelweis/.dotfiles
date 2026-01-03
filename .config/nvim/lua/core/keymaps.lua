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
vim.keymap.set({ "n", "t" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "n", "t" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "n", "t" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "n", "t" }, "<C-l>", "<C-\\><C-n><C-w>l")
