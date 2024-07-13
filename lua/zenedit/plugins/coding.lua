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
		lazy = false,
		keys = {
			{
				"<F3>",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return { timeout_ms = 500, lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype] }
			end,
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
