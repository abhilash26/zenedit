return {
	{
		"folke/noice.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				name = "notify",
				opts = {
					top_down = false,
					stages = "static",
          -- stylua: ignore
          max_height = function() return math.floor(vim.o.lines * 0.75) end,
					max_width = function()
						return math.floor(vim.o.columns * 0.75)
					end,
				},
			},
		},
    -- stylua: ignore
    init = function() vim.opt.lazyredraw = false end,
		opts = {
			messages = { view = "mini", view_warn = "mini" },
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
			routes = {
				{ filter = { event = "notify", find = "No information available" }, opts = { skip = true } },
			},
		},
	},
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				[".env"] = { glyph = "", hl = "MiniIconsYellow" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
				markdown = { glyph = "", hl = "MiniIconsBlue" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		lazy = false,
		opts = function()
			-- Define the ASCII logo
			local logo = [[
      ⠀⠀⠀⠀⠀⠀⢀⡴⠁⠀⠀⣠⠎⠀⠀⠀⣴⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⢠⣿⣧⡀⠀⢰⣿⣄⠀⠀⣾⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠙⠻⣿⣷⡌⠛⢿⣿⣦⠈⠛⢿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⡸⠟⠀⠀⢀⠿⠃⠀⠀⠀⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠿⣷⣦⡀⠀⠀⠀
      ⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠈⠻⣷⡀⠀⠀
      ⠀⠀⠀⠀⠘⣿⣿⣿⣿ZENEDIT⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⣿⡇⠀⠀
      ⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⣀⣾⡿⠁⠀⠀
      ⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣸⣿⣿⠿⠛⠁⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]

			-- Add padding and format the logo
			logo = string.rep("\n", 2) .. logo .. "\n\n"

			-- Configuration options for the dashboard
			local opts = {
				theme = "doom",
				hide = { statusline = true },
				config = {
					header = vim.split(logo, "\n"),
          -- stylua: ignore
					center = {
						{ action = "FzfLua files cwd=%:p:h", desc = "Find File", icon = " ", key = "f" },
						{ action = "ene | startinsert", desc = "New File", icon = " ", key = "n" },
						{ action = "FzfLua oldfiles", desc = "Recent Files", icon = " ", key = "r" },
						{ action = "e $MYVIMRC", desc = "Config", icon = " ", key = "c" },
						{ action = "Lazy", desc = "Lazy", icon = "󰒲 ", key = "l" },
            { action = 'lua require("persistence").select()', desc = "Sessions List", icon = " ", key = "s" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = "Quit", icon = " ", key = "q" },
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							string.format("⚡ Neovim loaded %d/%d plugins in %.2f ms", stats.loaded, stats.count, ms),
						}
					end,
				},
			}

			-- Right align the descriptions for consistent layout
			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- Open dashboard after closing Lazy window
			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end

			return opts
		end,
	},
}
