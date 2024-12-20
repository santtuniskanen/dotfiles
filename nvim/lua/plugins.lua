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
require("lazy").setup({
    -- Add plugins here
    "nvim-treesitter/nvim-treesitter",
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark_default')
        end
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            -- Read and define header from ascii.txt file
            local header = {}
            local ascii_path = vim.fn.stdpath("config") .. "/lua/header.txt"
            if vim.fn.filereadable(ascii_path) == 1 then
                header = vim.fn.readfile(ascii_path)
            else
                -- Fallback header if file doesn't exist
                header = {
                    "Welcome to Neovim",
                    "----------------",
                }
            end

            local footer_path = vim.fn.stdpath("config") .. "/lua/footer.txt"
            local footer_ascii = vim.fn.filereadable(footer_path) == 1 
            and vim.fn.readfile(footer_path) 
            or { "Ready to code!" }
            
            local db = require('dashboard')
            db.setup({
                theme = 'doom',
                config = {
                    header = header,
                    center = {
                        {
                            icon = ' ',
                            icon_hl = 'Title',
                            desc = 'Find File',
                            desc_hl = 'String',
                            key = 'f',
                            key_hl = 'Number',
                            action = 'Telescope find_files'
                        },
                        {
                            icon = ' ',
                            icon_hl = 'Title',
                            desc = 'Find Word',
                            desc_hl = 'String',
                            key = 'g',
                            key_hl = 'Number',
                            action = 'Telescope live_grep'
                        },
                        {
                            icon = ' ',
                            icon_hl = 'Title',
                            desc = 'Recent Files',
                            desc_hl = 'String',
                            key = 'r',
                            key_hl = 'Number',
                            action = 'Telescope oldfiles'
                        },
                        {
                            icon = ' ',
                            icon_hl = 'Title',
                            desc = 'Config',
                            desc_hl = 'String',
                            key = 'c',
                            key_hl = 'Number',
                            action = 'edit ~/.config/nvim/init.lua'
                        },
                        {
                            icon = '󰩈 ',
                            icon_hl = 'Title',
                            desc = 'Lazy',
                            desc_hl = 'String',
                            key = 'l',
                            key_hl = 'Number',
                            action = 'Lazy'
                        }
                    },
                    footer = footer_ascii,
                }
            })

            vim.g.start_time = vim.fn.reltime()
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
          "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
          -- configurations go here
        },
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "tabs",
                    separator_style = "slant",
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    color_icons = true,
                    diagnostics = "nvim_lsp",
                    -- This ensures that the tabs don't occupy nvim-tree's space
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true
                        }
                    },
                },
            })
    
            -- Keymaps for tab management
            vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { silent = true })  -- New tab
            vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', { silent = true })  -- Close tab
            vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { silent = true })  -- Next tab
            vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { silent = true })  -- Previous tab
        end
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup{
                -- Opens in bottom 20% of screen
                size = 10,
                open_mapping = [[<leader>t]],
                direction = 'horizontal'  -- or 'horizontal'/'vertical'/'tab'
            }
        end
    },    
    {'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '', right = ''},
              padding = 1,
            }
          },
          lualine_b = {
            {
              'branch',
              separator = { left = '', right = ''},
              padding = 1,
            },
            {
              'diff',
              separator = { left = '', right = ''},
              padding = 1,
            },
            {
              'diagnostics',
              separator = { left = '', right = ''},
              padding = 1,
            }
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              separator = { left = '', right = ''},
              padding = 1,
            }
          },
          lualine_x = {
            {
              'encoding',
              separator = { left = '', right = ''},
              padding = 1,
            },
            {
              'fileformat',
              separator = { left = '', right = ''},
              padding = 1,
            },
            {
              'filetype',
              separator = { left = '', right = ''},
              padding = 1,
            }
          },
          lualine_y = {
            {
              'progress',
              separator = { left = '', right = ''},
              padding = 1,
            }
          },
          lualine_z = {
            {
              'location',
              separator = { left = '', right = ''},
              padding = 1,
            }
          }
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
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("nvim-tree").setup {
                filesystem_watchers = {
                    enable = false,
                },
                update_focused_file = {
                    enable = true,
                    update_root = true,  -- Update root directory if file is outside current root
                    update_cwd = true,   -- Update working directory if root directory is updated
                },
            }
        end
    },
    {
        'neovim/nvim-lspconfig', -- LSP configuration plugin
        config = function()
            require('lspconfig').pyright.setup{}
            require('lspconfig').gopls.setup{}
            -- Add more LSP server setups here for other languages
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            require("ibl").setup {
                indent = {
                    highlight = highlight,
                    char = "│",
                },
                scope = {
                    enabled = true,
                    show_start = true,
                    show_end = true,
                    highlight = highlight,
                },
                exclude = {
                    filetypes = {
                        "dashboard",
                        "help",
                        "starter",
                        "nvim-tree",
                        "lazy",
                        "mason",
                    },
                    buftypes = {
                        "terminal",
                        "nofile",
                        "quickfix",
                        "prompt",
                    },
                },
            }
        end
    }
})