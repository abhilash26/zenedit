return {
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		cond = function()
			local term = os.getenv("TERM")
			return term and string.find(term, "tmux")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				untracked = { text = "▎" },
			},
		},
	},
}
