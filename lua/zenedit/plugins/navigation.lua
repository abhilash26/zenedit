return {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
			{ "<leader>-", "<cmd>Oil --float<CR>", desc = "Open parent directory" },
		},
		cmd = "Oil",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
      -- stylua: ignore
			if vim.fn.argc() ~= 1 then return end
			local stat = vim.uv.fs_stat(vim.fn.argv(0))
      -- stylua: ignore
			if stat and stat.type == "directory" then pcall(require, "oil") end
		end,
		opts = {
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = { show_hidden = true },
			float = { max_width = 75, max_height = 80 },
			preview = { min_width = { 70, 0.7 } },
		},
	},
	{
		"ibhagwan/fzf-lua",
		init = function()
			local lazy = require("lazy")
			vim.ui.select = function(...)
				lazy.load({ plugins = { "fzf-lua" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				lazy.load({ plugins = { "fzf-lua" } })
				return vim.ui.input(...)
			end
		end,
		cmd = "FzfLua",
		keys = {
			{ "<c-p>", "<cmd>FzfLua files<cr>", desc = "find files" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "buffers" },
			{ "<leader>ff", "<cmd>FzfLua files cwd=%:p:h<cr>", desc = "find files (cwd)" },
			{ "<leader>fg", "<cmd>FzfLua grep cwd=%:p:h<cr>", desc = "find in files (grep)" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "help pages" },
			{ "<leader>fm", "<cmd>FzfLua man_pages<cr>", desc = "man pages" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "recent files" },
			{ "<leader>ft", "<cmd>FzfLua colorschemes<cr>", desc = "colorschemes" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "keymaps" },
			{ "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "quickfix" },
			{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "git status" },
			{ "<leader>gb", "<cmd>FzfLua branches<cr>", desc = "git branches" },
		},
		opts = {
			profile = "fzf-native",
			grep = {
				rg_opts = "--sort-files --hidden --column --line-number --no-heading "
					.. "--color=always --smart-case -g '!{.git,node_modules,vendor,.next}/*'",
			},
			files = {
				fd_opts = "--type f --exclude node_modules --exclude .git --exclude vendor --exclude .next",
			},
		},
    -- stylua: ignore
		config = function() require("fzf-lua").register_ui_select() end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		opts = {
			sources = { "filesystem" },
			open_files_do_not_replace_types = { "terminal" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
	},
}
