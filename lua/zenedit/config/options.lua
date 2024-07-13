-- Options

local opt = vim.opt

-- Fix annoying things
opt.swapfile = false
opt.backup = false
opt.compatible = false
opt.undofile = true

-- Editor
opt.relativenumber = false
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.breakindent = true
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Highlight
opt.cursorline = false
-- opt.colorcolumn = "80"

-- Movement
opt.scrolloff = 8
opt.sidescrolloff = 8

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }

-- Coding
opt.syntax = "on"
opt.fileencoding = "utf-8"
opt.foldmethod = "manual"

-- clipboard and backspace
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- statusline and bufferline
opt.showmode = false
opt.laststatus = 2
opt.showtabline = 2
opt.conceallevel = 3

-- Speed of operation
opt.updatetime = 250
