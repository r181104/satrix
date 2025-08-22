return {
	"folke/trouble.nvim",
	cmd = "TroubleToggle",
	config = function()
		require("trouble").setup({ icons = true })
	end,
}
