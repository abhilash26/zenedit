return {
	{
		"folke/ts-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{
				"garymjr/nvim-snippets",
				dependencies = { "rafamadriz/friendly-snippets" },
				opts = { friendly_snippets = true },
			},
		},
		config = function()
			local cmp = require("cmp")
			local snip = vim.snippet
			local cmap = cmp.mapping

			local snip_jump = function(dir)
				if snip.active({ direction = dir }) then
					snip.jump(dir)
				end
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						snip.expand(args.body)
					end,
				},
				completion = { completeopt = "menu, menuone, noinsert, preview, noselect" },
				mapping = cmap.preset.insert({
					["<C-b>"] = cmap.scroll_docs(-4),
					["<C-f>"] = cmap.scroll_docs(4),
					["<C-n>"] = cmap.select_next_item(),
					["<C-p>"] = cmap.select_prev_item(),
					["<C-Space>"] = cmap.complete(),
					["<CR>"] = cmap.confirm({ select = true }),
					["<C-y>"] = cmap.confirm({ select = true }),
					["<C-e>"] = cmap.abort(),
					["<C-l>"] = cmap(snip_jump(1), { "i", "s" }),
					["<C-h>"] = cmap(snip_jump(-1), { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "path", keyword_length = 3 },
					{ name = "nvim_lsp", keyword_length = 1 },
					{ name = "buffer", keyword_length = 2 },
					{ name = "snippets", keyword_length = 2 },
					{ name = "lazydev", group_index = 0 },
				}),
			})
		end,
	},
}
