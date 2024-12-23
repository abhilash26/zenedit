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
		opts = function()
			local fzf = require("fzf-lua")
			return {
				servers = {
					emmet_ls = { filetypes = { "html", "php", "svelte", "vue" } },
					intelephense = { single_file_support = true },
					lua_ls = {
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								workspace = { checkThirdParty = false },
								completion = { callSnippet = "Replace" },
								diagnostics = { globals = { "vim" } },
								telemetry = { enable = false },
								hint = { enable = true, paramType = true, paramName = "Disable" },
								doc = { privateName = { "^_" } },
							},
						},
					},
					tailwindcss = { "react", "svelte", "vue", "html" },
					tsserver = {
						initializationOptions = { preferences = { includeCompletionsForModuleExports = false } },
					},
				},
				diagnostics = {
					underline = false,
					update_in_insert = false,
					virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
					severity_sort = true,
				},
				diagnostic_keymaps = {
					{ "n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic" } },
					{ "n", "d[", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic" } },
					{ "n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror message" } },
					{ "n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Show diagnostic [Q]uickfix list" } },
				},
				lsp_keymaps = {
					{ "n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" } },
					{ "n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition" } },
					{ "n", "gD", fzf.lsp_declarations, { desc = "[G]oto [D]eclaration" } },
					{ "n", "gi", fzf.lsp_implementations, { desc = "[G]oto [I]mplementation" } },
					{ "n", "go", fzf.lsp_typedefs, { desc = "Type [D]efinition" } },
					{ "n", "gr", fzf.lsp_references, { desc = "[G]oto [R]eferences" } },
					{ "n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" } },
					{ "n", "<leader>ws", fzf.lsp_workspace_symbols, { desc = "[W]orkspace [S]ymbols" } },
					{ "n", "<leader>ld", fzf.lsp_document_diagnostics, { desc = "[L]SP [D]ocument Diagnostics" } },
					{ "n", "<leader>lw", fzf.lsp_workspace_diagnostics, { desc = "[L]SP [W]orkspace Diagnostics" } },
					{ "n", "<leader>ca", fzf.lsp_code_actions, { desc = "[C]ode [A]ction" } },
					{ "n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" } },
				},
	  	-- stylua: ignore
				ensure_installed = {
					-- Linters
					"eslint_d", "phpcs", "pylint", "shellcheck",
					-- Formatters
					"black", "gofumpt", "isort", "php-cs-fixer", "prettierd", "shfmt", "stylua",
				},
			}
		end,
		config = function(_, opts)
			local map = vim.keymap.set
			local api = vim.api
			local diagnostic = vim.diagnostic

			-- Set diagnostic icons
			for name, icon in pairs(require("zenedit.icons").diagnostics) do
				vim.fn.sign_define(name, { text = icon, texthl = "DiagnosticSign" .. name })
			end

			-- Diagnostic settings
			diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Keymap setup for diagnostics
			for _, keymap in ipairs(opts.diagnostic_keymaps) do
				map(unpack(keymap))
			end

			-- LSP Attach function to setup keymaps
			local function lsp_attach()
				for _, keymap in ipairs(opts.lsp_keymaps) do
					map(unpack(keymap))
				end
			end

			-- Autocmd for LSP attach
			api.nvim_create_autocmd("LspAttach", {
				desc = "LSP action",
				group = api.nvim_create_augroup("zenedit_lsp_attach", { clear = true }),
				callback = lsp_attach,
			})

			-- Set server capabilities
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- Mason setup for tools
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.deepcopy(opts.ensure_installed),
			})

			-- Mason LSP setup
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = opts.servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
