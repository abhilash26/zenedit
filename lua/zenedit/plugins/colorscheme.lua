-- Colorschemes
return {
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		variant = "main",
    -- stylua: ignore
    config = function() vim.cmd.colorscheme("rose-pine") end,
	},
	{
		"bluz71/vim-moonfly-colors",
	},
	{
		"bluz71/vim-nightfly-colors",
	},
}
