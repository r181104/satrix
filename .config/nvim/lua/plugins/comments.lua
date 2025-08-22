return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
	config = function()
		require("todo-comments").setup()
	end,
}
