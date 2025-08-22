return {
	"folke/tokyonight.nvim",
    priority = 1000,
	lazy = false,
	opts = {},
	config = function()
		vim.cmd([[colorscheme tokyonight-night]])
	end,
}
