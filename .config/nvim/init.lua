-- Options
vim.g.mapleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.background = "light"
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.colorcolumn = "80"
vim.diagnostic.config({
	virtual_text = true,
})

-- Keymaps
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>", {
	desc = "Remove highlight after search",
})
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
	expr = true,
	silent = true,
	desc = "Go up 1 screen line",
})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
	expr = true,
	silent = true,
	desc = "Go down 1 screen line",
})
vim.keymap.set("n", "td", function()
	local cfg = vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_lines = not cfg.virtual_lines,
		virtual_text = not cfg.virtual_text,
	})
end, {
	desc = "Toggle diagnostic virtual lines",
})
vim.keymap.set("t", "<ESC>", "<C-\\><C-N>")
vim.keymap.set("t", "<C-[>", "<C-\\><C-N>")
vim.keymap.set("n", "<leader>bt", "<CMD>tab terminal<CR>")
vim.keymap.set("n", "<leader>bv", "<CMD>rightbelow vsplit | terminal<CR>")
vim.keymap.set("n", "<leader>bh", "<CMD>rightbelow split | terminal<CR>")
vim.keymap.set({ "n", "t" }, "<C-h>", "<C-\\><C-N><C-W>h")
vim.keymap.set({ "n", "t" }, "<C-j>", "<C-\\><C-N><C-W>j")
vim.keymap.set({ "n", "t" }, "<C-k>", "<C-\\><C-N><C-W>k")
vim.keymap.set({ "n", "t" }, "<C-l>", "<C-\\><C-N><C-W>l")

-- Autocmds
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt.spell = false
		vim.cmd.startinsert()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ "tpope/vim-surround" },
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})

			vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>;", "<Cmd>tab Git<CR>", {
				desc = "Open Fugitive in new tab",
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = false,
				disable_nvimtree_bg = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local treesitter = require("nvim-treesitter")
					local lang = vim.treesitter.language.get_lang(args.match)
					if vim.list_contains(treesitter.get_available(), lang) then
						if not vim.list_contains(treesitter.get_installed(), lang) then
							treesitter.install(lang):wait()
						end
						vim.treesitter.start(args.buf)
					end
				end,
				desc = "Enable nvim-treesitter and install parser if not installed",
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[BFR]",
							nvim_lsp = "[LSP]",
							luasnip = "[SNP]",
							path = "[PTH]",
						},
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("cssls")
			vim.lsp.enable("html")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("prismals")
			vim.lsp.enable("qmlls")
			vim.lsp.enable("tinymist")
			vim.lsp.enable("pyright")

			vim.lsp.config("tinymist", {
				settings = {
					formatterMode = "typstyle",
				},
			})
			vim.lsp.config("lua_ls", {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})

			vim.lsp.config("qmlls", {
				cmd = { "qmlls6" },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					c = { "clang-format" },
					lua = { "stylua" },
					sh = { "shfmt" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					markdown = { "prettier" },
				},
				formatters = {
					injected = {
						options = {
							lang_to_ft = {
								lua = "lua",
								bash = "sh",
							},
						},
					},
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
			})

			vim.keymap.set("n", "<leader>fm", require("conform").format, { desc = "Format file" })
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {
			open_cmd = "epiphany %s",
			port = 8000,
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>yf", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>u", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>i", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>o", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>p", function()
				harpoon:list():select(4)
			end)
		end,
	},
})
