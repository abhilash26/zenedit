return {
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			filetypes = { "css", "scss", "html", "php", "sass", "javascript", "svelte" },
			user_default_options = {
				css = true,
				css_fn = true,
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
	},
}
