local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("nvim-lua/plenary.nvim")
	add({
		source = "ThePrimeagen/harpoon",
		checkout = "harpoon2",
	})

	local harpoon = require("harpoon")
	harpoon:setup()

	-- Add file
	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end, { desc = "Harpoon add file" })

	-- Toggle quick menu
	vim.keymap.set("n", "<leader>yf", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Harpoon menu" })

	-- Direct jumps
	vim.keymap.set("n", "<leader>u", function()
		harpoon:list():select(1)
	end, { desc = "Harpoon 1" })

	vim.keymap.set("n", "<leader>i", function()
		harpoon:list():select(2)
	end, { desc = "Harpoon 2" })

	vim.keymap.set("n", "<leader>o", function()
		harpoon:list():select(3)
	end, { desc = "Harpoon 3" })

	vim.keymap.set("n", "<leader>p", function()
		harpoon:list():select(4)
	end, { desc = "Harpoon 4" })
end)
