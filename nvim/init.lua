require('options')
require('keybinds')
require('lsp')
require('pickers')

vim.opt.termguicolors = false
vim.cmd('syntax on')

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd('hi clear')
        local h = vim.api.nvim_set_hl
        -- syntax
        h(0, "Comment", { ctermfg = 4, bold = true })
        h(0, "Statement", { ctermfg = 130, bold = true })
        h(0, "Type", { ctermfg = 2, bold = true })
        h(0, "Constant", { ctermfg = 1 })
        h(0, "PreProc", { ctermfg = 5 })
        h(0, "Special", { ctermfg = 5 })
        h(0, "Identifier", { ctermfg = 6 })
        -- ui
        -- h(0, "LineNr", { ctermfg = 130 })
        h(0, "Search", { ctermbg = 11 })
        h(0, "MatchParen", { ctermbg = 14 })
        h(0, "Visual", { ctermfg = 0, ctermbg = 248 })
        h(0, "Pmenu", { ctermfg = 10, ctermbg = "NONE" })
        h(0, "PmenuSel", { reverse = true, bold = true })
        h(0, "PmenuSbar", { ctermbg = 8 })
        h(0, "PmenuThumb", { ctermbg = 7 })
    end
})
