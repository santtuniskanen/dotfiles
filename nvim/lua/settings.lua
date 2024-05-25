-- lua/settings.lua

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Set clipboard to use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Other settings
vim.opt.wrap = false
vim.opt.termguicolors = true
