local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("stevearc/conform.nvim")

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
		default_format_opts = { lsp_format = "fallback" },
	})

	vim.keymap.set("n", "<leader>fm", function()
		local client = vim.lsp.get_clients({
			name = "eslint",
			bufnr = vim.api.nvim_get_current_buf(),
		})[1]

		if not client then
			require("conform").format()
			return
		end

		vim.cmd("LspEslintFixAll")

		require("conform").format()
	end)
end)
