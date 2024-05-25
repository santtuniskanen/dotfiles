-- lua/plugins.lua
-- Check if lazy.nvim is already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with your plugins
require("lazy").setup({ -- Add plugins here
"nvim-treesitter/nvim-treesitter", -- Syntax highlighting and parsing
{
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('github-theme').setup({
            -- ...
        })

        vim.cmd('colorscheme github_dark_default')
    end
}, {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
        }
    end,
    dependencies = {{'nvim-tree/nvim-web-devicons'}}
}, {
    'nvim-lualine/lualine.nvim', -- Statusline
    requires = {
        'nvim-tree/nvim-web-devicons',
        opt = true
    },
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = {
                    left = '',
                    right = ''
                },
                section_separators = {
                    left = '',
                    right = ''
                },
                disabled_filetypes = {},
                always_divide_middle = true
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        })
    end
}, {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    -- or                              , branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'}
}, {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("nvim-tree").setup {}
    end
},
{
        'neovim/nvim-lspconfig', -- LSP configuration plugin
        config = function()
            require('lspconfig').pyright.setup{} -- Example: Python LSP server (Pyright)
            require('lspconfig').tsserver.setup{} -- Example: TypeScript LSP server (tsserver)
            require('lspconfig').gopls.setup{}
            -- Add more LSP server setups here for other languages
        end
    },})
