return {
	-- bashls
	bashls = {},
	-- clangd
	clangd = {},
	-- cssls
	cssls = {},
	-- emmet_ls
	emmet_ls = { filetypes = { "html", "php", "svelte", "vue" } },
	-- gopls
	gopls = {},
	-- html
	html = {},
	-- intelephense
	intelephense = { single_file_support = true },
	-- lua_ls
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = { checkThirdParty = false },
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
				telemetry = { enable = false },
				hint = { enable = true },
			},
		},
	},
	-- pyright
	pyright = {},
	-- tailwindcss
	tailwindcss = { "react", "svelte", "html" },
	-- tsserver
	tsserver = {
		initializationOptions = {
			preferences = { includeCompletionsForModuleExports = false },
		},
	},
}
