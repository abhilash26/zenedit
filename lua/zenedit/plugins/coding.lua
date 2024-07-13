return {
	{
		"echasnovski/mini.surround",
		name = "mini.surround",
		keys = { "ys", "ds", "cs" },
		opts = {
			mappings = { add = "ys", delete = "ds", replace = "cs" },
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
    -- stylua: ignore
    keys = {
      { "<F3>", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "[F]ormat buffer" },
    },
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				-- javascriptreact = { "prettierd" },
				-- typescriptreact = { "prettierd" },
				svelte = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				lua = { "stylua" },
				python = { "isort", "black" },
				php = { "php-cs-fixer" },
				go = { "gofumpt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
		},
	},
}
