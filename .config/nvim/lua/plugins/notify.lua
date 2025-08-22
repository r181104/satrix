return {
	"vigoux/notifier.nvim",
	config = function()
		require("notifier").setup({
			{
				status_width = something,
				components = {
					"nvim",
					"lsp",
				},
				notify = {
					clear_time = 5000,
					min_level = vim.log.levels.INFO,
				},
				component_name_recall = false,
				zindex = 50,
			},
		})
	end,
}
