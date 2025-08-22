return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				go = { "gofumpt", "goimports" },
				rust = { "rustfmt" },
				nix = { "alejandra" },
				sh = { "shfmt" },
				yaml = { "yamlfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				java = { "google-java-format" },
				sql = { "sqlfmt" },
				hyprlang = { "shfmt" },
			},
		})
	end,
}
