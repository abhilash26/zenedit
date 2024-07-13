return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
    -- stylua: ignore
		keys = {
			{ "<leader>sl", function() require("persistence").load({ last = true }) end, "[S]ession [L]oad"	},
			{ "<leader>sf", function() require("persistence").select() end,	"[S]ession [F]ind" },
		},
		opts = {
			options = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = { { path = "luvit-meta/library", words = { "vim%.uv" } } },
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, { name = "lazydev", group_index = 0 })
		end,
	},
}
