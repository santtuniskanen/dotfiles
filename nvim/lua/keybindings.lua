-- lua/keybindings.lua

-- Leader key
vim.g.mapleader = ' '

-- Normal mode keybindings
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })

-- Insert mode keybindings
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Toggle NvimTree file explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-- Tab management
vim.keymap.set('n', '<leader>1', '1gt', { silent = true })  -- Go to tab 1
vim.keymap.set('n', '<leader>2', '2gt', { silent = true })  -- Go to tab 2
vim.keymap.set('n', '<leader>3', '3gt', { silent = true })  -- Go to tab 3
vim.keymap.set('n', '<leader>4', '4gt', { silent = true })  -- Go to tab 4
vim.keymap.set('n', '<leader>5', '5gt', { silent = true })  -- Go to tab 5

-- Move tabs
vim.keymap.set('n', '<leader>tmr', ':tabmove +1<CR>', { silent = true })  -- Move tab right
vim.keymap.set('n', '<leader>tml', ':tabmove -1<CR>', { silent = true })  -- Move tab left