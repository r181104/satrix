return {
	"norcalli/nvim-colorizer.lua",
	cmd = "ColorizerToggle",
	config = function()
		require("colorizer").setup({
			filetypes = { "*" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				rgba_fn = true,
				hsl_fn = true,
				hsla_fn = true,
				css = true,
				css_fn = true,
				names = true,
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
				mode = "background",
				virtualtext = "■",
				always_update = true,
			},
		})
	end,
}
