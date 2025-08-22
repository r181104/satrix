vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function()
		local map = vim.keymap.set
		-- LSP
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "<leader>ws", vim.lsp.buf.workspace_symbol)
		map("n", "<leader>fd", vim.diagnostic.open_float)
		map("n", "<leader>ca", vim.lsp.buf.code_action)
		map("n", "<leader>gr", vim.lsp.buf.references)
		map("n", "<leader>rn", vim.lsp.buf.rename)
		map("n", "<leader>for", vim.lsp.buf.format)
		map("n", "<leader>fe", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		map("n", "<leader>ce", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})
