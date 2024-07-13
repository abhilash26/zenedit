-- Load Lazy if not exists

local lazypath = string.format("%s%s", vim.fn.stdpath("data"), "/lazy/lazy.nvim")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
	if vim.v.shell_error == 0 then return end
	vim.api.nvim_echo({
		{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
		{ out, "WarningMsg" },
		{ "\nPress any key to exit..." },
	}, true, {})
	vim.fn.getchar()
	os.exit(1)
end

-- Add lazypath to RTP
vim.opt.rtp:prepend(lazypath)

-- stylua: ignore
local success, lazy = pcall(require, "lazy")
if not success then return end

-- stylua: ignore
local disabled_plugins = {
	"2html_plugin", "bugreport", "compiler", "getscript", "getscriptPlugin", "gzip", "logipat",
	"matchit", "matchparen", "netrw", "netrwFileHandlers", "netrwPlugin", "netrwSettings",
	"optwin", "rplugin", "rrhelper", "spellfile_plugin", "synmenu", "syntax", "tar", "tarPlugin",
	"tohtml", "tutor", "vimball", "vimballPlugin", "zip", "zipPlugin" }

lazy.setup({
	spec = {
		{ import = "zenedit.plugins" },
	},
	defaults = {
		lazy = true,
		version = "*",
	},
	install = { colorscheme = { "rose-pine-main", "default", "habamax" } },
	checker = { enabled = false },
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = disabled_plugins,
		},
	},
})
