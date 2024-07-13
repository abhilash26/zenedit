return {
	-- TMUX Integration
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		cond = function()
			-- Only enable when opened in tmux
			local term = os.getenv("TERM")
			return term and string.find(term, "tmux")
		end,
	},
	-- Git Integration
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
