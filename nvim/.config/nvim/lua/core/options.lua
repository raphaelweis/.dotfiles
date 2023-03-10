-- appearance
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers wrapping cursor line (10 lines)
vim.opt.termguicolors = true -- enable 24-bit RGB color for the UI
vim.opt.background = "dark" -- choose preferred option for the colorscheme (light/dark)
vim.opt.signcolumn = "auto" -- draws a column on the left to display things like breakpoints (auto = only when necessary)
vim.opt.showmode = false -- prevent neovim from displaying current mode since the status line already does it

-- text editing
vim.opt.tabstop = 2 -- tabs = 2 spaces
vim.opt.shiftwidth = 2 -- indentation = 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- copy indent from current line when going to a new line
vim.opt.wrap = false -- lines that are too long will not get cut to show on the line under them
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]]) -- prevent neovim from automatically commenting new lines
