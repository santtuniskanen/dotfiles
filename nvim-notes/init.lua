-- ~/.config/nvim-notes/init.lua
vim.cmd.colorscheme('rose-pine-dawn')

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  -- Vimwiki for note-taking
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/notes/',
          syntax = 'markdown',
          ext = '.md',
        }
      }
      vim.g.vimwiki_global_ext = 0  -- Don't treat all .md files as vimwiki
    end,
  },

  -- Telescope for fuzzy finding notes
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{}
      
      -- Keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    end,
  },

  -- Markdown preview (optional)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Better markdown syntax
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_frontmatter = 1
    end,
  },
})

-- Additional keymaps
vim.keymap.set('n', '<leader>ww', ':VimwikiIndex<CR>', { desc = 'Open wiki index' })
vim.keymap.set('n', '<leader>wt', ':VimwikiTable<CR>', { desc = 'Create table' })

-- Auto-create notes directory if it doesn't exist
vim.fn.mkdir(vim.fn.expand('~/notes'), 'p')
