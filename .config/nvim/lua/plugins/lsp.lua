local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("neovim/nvim-lspconfig")

	vim.lsp.enable({
		"lua_ls",
		"clangd",
		"ts_ls",
		"eslint",
		"cssls",
		"html",
		"jsonls",
		"prismals",
		"qmlls",
		"tinymist",
		"pyright",
	})

	vim.lsp.config("tinymist", {
		settings = { formatterMode = "typstyle" },
	})

	vim.lsp.config("qmlls", { cmd = { "qmlls6" } })

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = { globals = "MiniDeps" },
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
					},
				},
			},
		},
	})
end)
