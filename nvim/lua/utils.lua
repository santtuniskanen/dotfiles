-- lua/utils.lua

-- Example utility function
    local M = {}

    function M.reload_config()
        vim.cmd('source ~/.config/nvim/init.lua')
    end
    
    function M.open_config()
        vim.cmd('edit ~/.config/nvim/init.lua')
    end
    
    function M.neovim_version()
        return vim.version()
    end
    
    return M
    