-- Keymaps

local map_set = vim.keymap.set

local map = function(mode, lhs, rhs, desc, expr)
	local opts = { noremap = true, silent = true, expr = false, desc = desc }
	if expr then opts.expr = true end
	map_set(mode, lhs, rhs, opts)
end

map("", "<space>", "<nop>", "leader remapping")

-- Setting space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Windows / Splits
--
-- Move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<c-w>h", "Go to left window")
map("n", "<c-j>", "<c-w>j", "Go to lower window")
map("n", "<c-k>", "<c-w>k", "Go to upper window")
map("n", "<c-l>", "<c-w>l", "Go to right window")

-- Resize window using <ctrl> arrow keys
map("n", "<c-up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<c-down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<c-right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Buffers
map("n", "<s-l>", "<cmd>bnext<cr>", "Move to right buffer")
map("n", "<s-h>", "<cmd>bprevious<cr>", "Move to left buffer")
map("n", "<bs>", "<cmd>b#<cr>", "Move to last buffer")
map("n", "<c-q>", "<cmd>bd!<cr>", "[B]uffer [Q]uit")
map("n", "<leader>fn", "<cmd>ene <bar> startinsert <cr>", "[B]uffer [N]ew")
map("n", "<leader>bq", "<cmd>bd!<cr>", "[B]uffer [Q]uit")
map("n", "<leader>be", "<cmd>%bd|e#<cr>", "Close other buffers")

-- Better Paste
map("v", "p", '"_dP', "paste")

-- Better indenting
map("v", "<", "<gv", "indent to left")
map("v", ">", ">gv", "indent to right")

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", "Move Down one line", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", "Move Up one line", { expr = true, silent = true })

-- Move lines up and down
map("v", "<s-j>", ":m '>+1<cr>gv=gv", "Move down")
map("v", "<s-k>", ":m '<-2<cr>gv=gv", "Move up")

-- Save file
map({ "n", "i", "v", "x" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")

-- use Enter in normal mode to add a new line
map("n", "<cr>", "o<esc>", "New Line")

-- page up and down
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")

-- normal copy and paste
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", [["_d]])
map({ "n", "v" }, "<leader>y", [["+y]])

map("n", "<leader>wq", "<cmd>wqa<cr>", "[W]rite and [Q]uit")
