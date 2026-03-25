vim.keymap.set("n", "<leader>t", function()
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative  = "editor",
        width     = width,
        height    = height,
        row       = row,
        col       = col,
        style     = "minimal",
        border    = "rounded",
        title     = " Terminal ",
        title_pos = "center",
    })

    vim.fn.termopen(vim.o.shell, {
        on_exit = function()
            vim.schedule(function()
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_close(win, true)
                end
            end)
        end,
    })
    vim.cmd("startinsert")
end, { desc = "Open terminal float" })

vim.keymap.set("n", "<leader>?", function()
    local md = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h") .. "/KEYBINDS.md"
    if vim.fn.filereadable(md) == 0 then
        vim.notify("KEYBINDS.md not found", vim.log.levels.ERROR)
        return
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative  = "editor",
        width     = width,
        height    = height,
        row       = row,
        col       = col,
        style     = "minimal",
        border    = "rounded",
        title     = " Keybinds ",
        title_pos = "center",
    })

    vim.fn.termopen("glow --pager --width " .. width .. " " .. vim.fn.shellescape(md), {
        on_exit = function()
            vim.schedule(function()
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_close(win, true)
                end
            end)
        end,
    })
    vim.cmd("startinsert")

    vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<Escape>", function()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end, { buffer = buf, nowait = true })
end, { desc = "Show keybinds" })

vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Prev quickfix" })
vim.keymap.set("n", "<leader>q", function()
    local wins = vim.fn.getqflist({ winid = 0 }).winid
    if wins ~= 0 then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle quickfix" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)  -- go to definition
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)  -- find references

        vim.keymap.set("n", "K", function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                    vim.api.nvim_win_close(win, false)
                    return
                end
            end
            vim.lsp.buf.hover({ border = "rounded", max_width = 80 })
        end, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)      -- rename symbol
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code actions
        vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        if client and client.supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
            })
        end

        if client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
                    { bufnr = ev.buf }
                )
                vim.notify("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }) and "on" or "off"),
                    vim.log.levels.INFO)
            end, { buffer = ev.buf, desc = "Toggle inlay hints" })
        end
    end,
})

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then return "<C-n>" end
    return "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then return "<C-p>" end
    return "<S-Tab>"
end, { expr = true })

vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() == 1 then return "<C-y>" end
    return "<CR>"
end, { expr = true })
