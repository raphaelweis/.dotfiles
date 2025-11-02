-- Leader
vim.g.mapleader = " "

-- Disable built-in providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable netrw (we use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.winborder = "rounded"
vim.opt.swapfile = false
vim.opt.clipboard:append("unnamedplus")

-- Miscellaneous
vim.diagnostic.config({ virtual_text = true })

-- Keymaps
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>")
vim.keymap.set("n", "<leader>R", "<CMD>restart<CR>")

-- Bootstrap lazy.nvim if not installed
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

-- Plugin setup with lazy.nvim
require("lazy").setup({
	{
		"vague-theme/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup()
			vim.cmd("colorscheme vague")
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>")
		end,
	},
	{ "tpope/vim-surround" },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
		end,
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
				harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded", title_pos = "center" })
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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "%.git/" },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})

			require("telescope").load_extension("fzf")

			vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
			vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"lua-language-server",
					"typescript-language-server",
					"stylua",
					"prettier",
					"eslint-lsp",
					"clangd",
					"clang-format",
					"tinymist",
					"typstyle",
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
							path = { "lua/?.lua", "lua/?/init.lua" },
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
				settings = { Lua = {} },
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("vala_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("tinymist")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					javascriptreact = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					yaml = { "prettier" },
					vala = { "uncrustify" },
					c = { "uncrustify", "clang-format" },
					typst = { "typstyle" },
				},
			})
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
			vim.keymap.set("n", "<leader>fm", "<CMD>Format<CR>")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")

			local cmp_kinds = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				}),
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
						return vim_item
					end,
				},
			})
		end,
	},
})
