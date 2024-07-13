return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
		opts_extend = { "ensure_installed" },
		opts = {
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
      -- stylua: ignore
			ensure_installed = {
				"bash", "c", "cpp", "css", "go", "html", "javascript", "json", "lua",
				"markdown", "markdown_inline", "php", "python", "rasi", "dockerfile",
				"regex", "scss", "sql", "yaml", "toml", "xml", "tsx", "diff", "vim",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
