return require('packer').startup(function(use)
  -- Packer can manage itself
  use ({ 'wbthomason/packer.nvim' })

  use ({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

  use ({ 'projekt0n/github-nvim-theme' })

  use ({ 'vim-airline/vim-airline' })

  use ({ 'vim-airline/vim-airline-themes' })

  use ({ 'nvim-lua/plenary.nvim' })

  use ({ 'nvim-tree/nvim-web-devicons' })

  use ({ 'nvim-telescope/telescope.nvim' })

  use ({'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'})

  use ({
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
})

  use ({ 'neovim/nvim-lspconfig' })

end)
