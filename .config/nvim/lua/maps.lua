local map = vim.keymap.set
local pick = require("mini.pick")

-- General
map("n", "<leader>so", ":update<CR> :source<CR>")
map("n", "<leader>si", "source ~/.config/nvim/init.lua<CR>")
map("n", "<leader>rr", ":restart<CR>")
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<C-c>", "<cmd>nohlsearch<CR>")
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })

-- File explorer & LazyGit
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil file explorer" })
map("n", "<leader>git", ":LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>ter", ":vsplit | terminal<CR>", { desc = "Open terminal in vertical split" })

-- Tmux navigator
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to left split" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to below split" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to above split" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to right split" })

-- Git Blame
map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })

-- Mini.pick
map("n", "<leader>ff", function()
	pick.builtin.files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
	pick.builtin.grep_live()
end, { desc = "Search text (live grep)" })
map("n", "<leader>fb", function()
	pick.builtin.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
	pick.builtin.help()
end, { desc = "Search help tags" })

-- Colorizer toggle
map("n", "<leader>tc", "<cmd>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })

-- Prime's remaps
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Conform
map({ "n", "v" }, "<leader>fm", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
		timeout_ms = 500,
	})
end, { desc = "[F]or[m]at buffer" })
map("v", "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
		range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
	})
end, { desc = "[F]ormat selection" })

-- Trouble
map("n", "<leader>tt", function()
	require("trouble").toggle()
end)
map("n", "[d", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
map("n", "]d", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)
