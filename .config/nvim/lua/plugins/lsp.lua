return {
	"neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
		vim.lsp.config("clangd", {})
		vim.lsp.config("gopls", {})
		vim.lsp.config("pylsp", {})
		vim.lsp.config("html", {})
		vim.lsp.config("cssls", {})
		vim.lsp.config("jsonls", {})
		vim.lsp.config("eslint", {})
		vim.lsp.config("nixd", {})
		vim.lsp.config("hyprls", {})
		vim.lsp.config("rust_analyzer", {})
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
		vim.lsp.enable({
			"clangd",
			"gopls",
			"pylsp",
			"html",
			"cssls",
			"jsonls",
			"eslint",
			"nixd",
			"hyprls",
			"rust_analyzer",
			"lua_ls",
		})
	end,
}
