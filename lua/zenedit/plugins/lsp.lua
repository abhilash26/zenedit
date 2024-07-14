return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", cmd = "Mason" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		version = false,
		config = function()
			local map = vim.keymap.set

			-- diagnostic settings
			local d = vim.diagnostic

			map("n", "[d", d.goto_prev, { desc = "Go to previous [D]iagnostic" })
			map("n", "d[", d.goto_next, { desc = "Go to next [D]iagnostic" })
			map("n", "<leader>de", d.open_float, { desc = "Show diagnotic [E]rror message" })
			map("n", "<leader>dq", d.setloclist, { desc = "Show diagnotic [Q]uickfix list" })

			for name, icon in pairs(require("zenedit.icons").diagnostics) do
				vim.fn.sign_define(name, { text = icon, texthl = "DiagnosticSign" .. name, numhl = "" })
			end

			vim.diagnostic.config({
				underline = false,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
			})

			-- on attach function
			local api = vim.api
			local lsp = vim.lsp
			local fzf = require("fzf-lua")

			local lsp_attach = function(_)
				map("n", "K", lsp.buf.hover, { desc = "Hover Documentation" })
				map("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition" })
				map("n", "gD", fzf.lsp_declarations, { desc = "[G]oto [D]eclaration" })
				map("n", "gi", fzf.lsp_implementations, { desc = "[G]oto [I]mplementation" })
				map("n", "go", fzf.lsp_typedefs, { desc = "Type [D]efinition" })
				map("n", "gr", fzf.lsp_references, { desc = "[G]oto [R]eferences" })
				map("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
				map("n", "<leader>ws", fzf.lsp_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
				map("n", "<leader>ld", fzf.lsp_document_diagnostics, { desc = "[L]SP [D]ocument Diagnostics" })
				map("n", "<leader>lw", fzf.lsp_workspace_diagnostics, { desc = "[L]SP [W]orkspace Diagnostics" })
				map("n", "<leader>ca", fzf.lsp_code_actions, { desc = "[C]ode [A]ction" })
				map("n", "<F2>", lsp.buf.rename, { desc = "Rename" })
			end

			api.nvim_create_autocmd("LspAttach", {
				desc = "LSP action",
				group = api.nvim_create_augroup("zenedit_lsp_attach", { clear = true }),
				callback = lsp_attach,
			})

			-- Set server capabilities
			local capabilities = lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Set lsp servers config
			local servers = require("zenedit.plugins.lsp_configs.servers")

			local ensure_installed = vim.tbl_keys(servers) or {}
			vim.list_extend(ensure_installed, {
				-- Linters
				"eslint_d",
				"phpcs",
				"pylint",
				"shellcheck",
				-- Formatters
				"black",
				"gofumpt",
				"isort",
				"php-cs-fixer",
				"prettierd",
				"shfmt",
				"stylua",
			})

			-- Install all mason tools
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			-- Mason setup
			require("mason").setup()

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
