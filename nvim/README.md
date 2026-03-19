# nvim

This config is admittely pretty vibe-coded. I'm not too familiar with neovim
and the config options it has, so I just prompted AI and it did a surprisingly good job. 
I wanted to have a zero-plugin config that I can use to quickly edit files (I don't daily drive neovim) and 
I was surprised to find out that neovim has a pretty good LSP support and the ability
to do autocomplete and suggestions. Maybe I need to explore the config options more in the future.

## requirements
colorscheme: [sainnhe/everforest](https://github.com/sainnhe/everforest)

`git clone https://github.com/sainnhe/everforest \
  ~/.local/share/nvim/site/pack/themes/start/everforest
`

telescope-like functionality needs at least `ripgrep`. I don't remember if this 
config had any other requirements. LSP support requires that the configured LSPs 
are installed (gopls, clangd, zls).
