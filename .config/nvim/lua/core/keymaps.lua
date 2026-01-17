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
vim.keymap.set("t", "<C-]>", "<C-\\><C-n>")

vim.keymap.set("n", "=", "<CMD>vertical resize +5<CR>")
vim.keymap.set("n", "-", "<CMD>vertical resize -5<CR>")
vim.keymap.set("n", "+", "<CMD>horizontal resize +2<CR>")
vim.keymap.set("n", "_", "<CMD>horizontal resize -2<CR>")

local term_buf = nil
local term_win = nil
local term_height = 15

local function open_terminal()
	if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd("botright split")
		vim.cmd("resize " .. term_height)
		vim.cmd("terminal")
		term_win = vim.api.nvim_get_current_win()
		term_buf = vim.api.nvim_get_current_buf()
		vim.cmd("startinsert")
		return
	end

	if not term_win or not vim.api.nvim_win_is_valid(term_win) then
		vim.cmd("botright split")
		vim.cmd("resize " .. term_height)
		vim.api.nvim_win_set_buf(0, term_buf)
		term_win = vim.api.nvim_get_current_win()
		vim.cmd("startinsert")
	end
end

local function hide_terminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
	end
end

local function toggle_terminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		hide_terminal()
	else
		open_terminal()
	end
end

vim.keymap.set("n", "<leader>t", toggle_terminal, {
	noremap = true,
	silent = true,
	desc = "Toggle bottom terminal",
})
