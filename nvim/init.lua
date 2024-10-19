-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.undofile = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard:append("unnamedplus")

-- Keymaps
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Lazy.nvim setup
require("lazy").setup({
	spec = {
		"tpope/vim-surround",
		"tpope/vim-obsession",
		"mfussenegger/nvim-jdtls",
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "windwp/nvim-ts-autotag", opts = {} },
		{ "lewis6991/gitsigns.nvim", opts = {} },
		{ "tpope/vim-fugitive", keys = { { "<leader>;", "<CMD>tab Git<CR>" } } },
		{
			"numToStr/Comment.nvim",
			dependencies = {
				{
					"JoosepAlviste/nvim-ts-context-commentstring",
					opts = { enable_autocmd = false },
				},
			},
			config = function()
				require("Comment").setup({
					pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				})
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
		{
			"stevearc/oil.nvim",
			opts = {
				keymaps = {
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-l>"] = false,
				},
			},
		},
		{
			"stevearc/dressing.nvim",
			opts = {
				select = {
					backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
					builtin = {
						relative = "cursor",
						override = function(conf)
							conf.anchor = "NW"
							conf.row = 1
						end,
					},
				},
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && npm install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = { { "folke/neodev.nvim", opts = {} } },
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("r-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end
						map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
						map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
						map("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
						map("<leader>gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
						map("K", vim.lsp.buf.hover, "Hover Documentation")
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
						map("<F2>", vim.diagnostic.goto_next, "Go to next diagnostic")
						map("<F2>", vim.diagnostic.goto_prev, "Go to previous diagnostic")
					end,
				})

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				local servers = {
					ts_ls = {},
					nil_ls = {},
					html = {},
					cssls = {},
					jsonls = {},
					yamlls = {},
					pyright = {},
					dockerls = {},
					docker_compose_language_service = {},
					clangd = {},
					bashls = {},
					eslint = {
						on_attach = function()
							vim.keymap.set("n", "<leader>fm", "<CMD>EslintFixAll<CR>")
						end,
					},
					lua_ls = {
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end
							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = false,
									library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
								},
							})
						end,
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = { disable = { "missing-fields" } },
							},
						},
					},
				}
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				{
					"L3MON4D3/LuaSnip",
					build = (function()
						if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
							return
						end
						return "make install_jsregexp"
					end)(),
					dependencies = {
						{
							"rafamadriz/friendly-snippets",
							config = function()
								require("luasnip.loaders.from_vscode").lazy_load()
							end,
						},
					},
				},
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					completion = { completeopt = "menu,menuone,noinsert" },
					mapping = cmp.mapping.preset.insert({
						["<C-n>"] = cmp.mapping.select_next_item(),
						["<C-p>"] = cmp.mapping.select_prev_item(),
						["<C-d>"] = cmp.mapping.scroll_docs(-4),
						["<C-u>"] = cmp.mapping.scroll_docs(4),
						["<C-y>"] = cmp.mapping.confirm({ select = true }),
						["<C-Space>"] = cmp.mapping.complete({}),
						["<C-l>"] = cmp.mapping(function()
							if luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							end
						end, { "i", "s" }),
						["<C-h>"] = cmp.mapping(function()
							if luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							end
						end, { "i", "s" }),
					}),
					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "path" },
						{ name = "buffer" },
					},
				})
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {},
		},
		{
			"navarasu/onedark.nvim",
			opts = { style = "darker", transparent = true },
		},
		{
			"christoomey/vim-tmux-navigator",
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
			},
			keys = {
				{ "<c-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
				{ "<c-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
				{ "<c-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
				{ "<c-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
				{ "<c-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = "all",
					auto_install = true,
					highlight = { enable = true },
					indent = { enable = true },
				})

				-- Automatic hyprland filetype detection for highlighting.
				vim.filetype.add({
					pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
				})
			end,
		},
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>fm",
					function()
						require("conform").format({ async = true })
					end,
				},
			},
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					nix = { "nixfmt" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					jsonc = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					python = { "black" },
					c = { "clang-format" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					java = { "google-java-format" },
				},
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			opts = {},
			keys = {
				{ "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>" },
				{ "<leader>fs", "<CMD>Telescope live_grep<CR>" },
				{ "<leader>gc", "<CMD>Telescope git_branches<CR>" },
			},
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
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
	},
	install = { colorscheme = { "onedark" } },
})

vim.cmd("colorscheme onedark")
