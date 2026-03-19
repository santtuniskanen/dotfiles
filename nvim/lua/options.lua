vim.g.mapleader = " "

vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.list = false
vim.opt.listchars = { tab = "→ ", trail = "·", lead = "·", nbsp = "␣" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.statusline = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.laststatus = 0
vim.opt.fillchars = { eob = " " }

vim.opt.autoread = true
vim.cmd("filetype plugin indent on")

-- use parsers from the old nvim-treesitter install
vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/lazy/nvim-treesitter"))
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.bo.keywordprg = ":echo"
    end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })

vim.cmd("colorscheme default")
vim.cmd("syntax on")

-- enable treesitter highlighting for filetypes we have parsers for
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "go", "lua", "javascript", "rust", "zig", "markdown" },
    callback = function(ev)
        local ok, _ = pcall(vim.treesitter.start, ev.buf)
        if not ok then
            vim.cmd("syntax on") -- fallback to regex syntax
        end
    end,
})

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 15 })
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = "NONE", ctermfg = 3 })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermbg = 3, ctermfg = 0 })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})




-- Toggle whitespace visibility
vim.keymap.set("n", "<leader>w", function()
    vim.opt.list = not vim.o.list
    vim.notify("Whitespace " .. (vim.o.list and "on" or "off"), vim.log.levels.INFO)
end, { desc = "Toggle whitespace markers" })
