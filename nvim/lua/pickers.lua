-- shared helper: open a floating window
local function float(opts)
    local width  = math.floor(vim.o.columns * (opts.width or 0.8))
    local height = math.floor(vim.o.lines * (opts.height or 0.8))
    local row    = math.floor((vim.o.lines - height) / 2)
    local col    = math.floor((vim.o.columns - width) / 2)

    local buf    = vim.api.nvim_create_buf(false, true)
    local win    = vim.api.nvim_open_win(buf, true, {
        relative  = "editor",
        width     = width,
        height    = height,
        row       = row,
        col       = col,
        style     = "minimal",
        border    = "rounded",
        title     = opts.title and (" " .. opts.title .. " ") or nil,
        title_pos = opts.title and "center" or nil,
    })
    return buf, win
end

-- shared helper: open a fzf terminal picker in a float
local function fzf_float(fzf_cmd, on_select)
    local tempfile = vim.fn.tempname()
    local buf, win = float({})

    vim.fn.termopen(fzf_cmd .. " > " .. tempfile, {
        on_exit = function()
            local f = io.open(tempfile, "r")
            if f then
                local result = vim.trim(f:read("*a"))
                f:close()
                os.remove(tempfile)
                vim.schedule(function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                    if result ~= "" then
                        on_select(result)
                    end
                end)
            end
        end,
    })
    vim.cmd("startinsert")
end

-- shared helper: open a static list in a float, returns buf/win with q/Escape/CR bound
local function list_float(title, lines, on_select)
    local buf, win = float({ title = title, width = 0.6, height = 0.5 })

    -- clamp height to content
    local height = math.min(#lines, math.floor(vim.o.lines * 0.5))
    vim.api.nvim_win_set_height(win, math.max(height, 1))

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    local function close()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<Escape>", close, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<CR>", function()
        local lnum = vim.api.nvim_win_get_cursor(win)[1]
        close()
        on_select(lnum)
    end, { buffer = buf, nowait = true })
end


-- File finder
vim.keymap.set("n", "<leader>ff", function()
    fzf_float(
        "rg --files --hidden | fzf --border=none" ..
        " --preview='bat --style=numbers --color=always {1} 2>/dev/null || cat {1}'" ..
        " --preview-window='right:50%'",
        function(result)
            vim.cmd.edit(result)
        end
    )
end)


-- Live grep
vim.keymap.set("n", "<leader>fg", function()
    local cmd = table.concat({
        "fzf --disabled --ansi --border=none",
        "--prompt='Grep> '",
        "--bind='start:reload:rg --column --line-number --no-heading --color=always --smart-case \"\" || true'",
        "--bind='change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true'",
        "--delimiter=':'",
        "--preview='bat --style=numbers --color=always --highlight-line {2} {1} 2>/dev/null || cat {1}'",
        "--preview-window='right:50%:+{2}-5'",
    }, " ")

    fzf_float(cmd, function(result)
        local file, lnum = result:match("^([^:]+):(%d+):")
        if file and lnum then
            vim.cmd.edit(file)
            vim.api.nvim_win_set_cursor(0, { tonumber(lnum), 0 })
        end
    end)
end)


-- Grep word under cursor
vim.keymap.set("n", "<leader>fs", function()
    local word = vim.fn.expand("<cword>")
    if word == "" then return end

    local cmd = table.concat({
        "fzf --disabled --ansi --border=none",
        "--prompt='Grep> '",
        "--query=" .. vim.fn.shellescape(word),
        "--bind='start:reload:rg --column --line-number --no-heading --color=always --smart-case " ..
        vim.fn.shellescape(word) .. " || true'",
        "--bind='change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true'",
        "--delimiter=':'",
        "--preview='bat --style=numbers --color=always --highlight-line {2} {1} 2>/dev/null || cat {1}'",
        "--preview-window='right:50%:+{2}-5'",
    }, " ")

    fzf_float(cmd, function(result)
        local file, lnum = result:match("^([^:]+):(%d+):")
        if file and lnum then
            vim.cmd.edit(file)
            vim.api.nvim_win_set_cursor(0, { tonumber(lnum), 0 })
        end
    end)
end)


-- Buffer picker
vim.keymap.set("n", "<leader>fb", function()
    local bufs = {}
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(b)
        if vim.api.nvim_buf_is_loaded(b) and name ~= "" and not name:match("^term://") then
            table.insert(bufs, { id = b, name = name })
        end
    end
    if #bufs == 0 then return end

    local lines = {}
    for _, b in ipairs(bufs) do
        table.insert(lines, vim.fn.fnamemodify(b.name, ":~:."))
    end

    list_float("Buffers", lines, function(lnum)
        local chosen = bufs[lnum]
        if chosen then vim.cmd("buffer " .. chosen.id) end
    end)
end)


-- Recent files
vim.keymap.set("n", "<leader>fr", function()
    local files = {}
    for _, f in ipairs(vim.v.oldfiles) do
        if vim.fn.filereadable(f) == 1 then
            table.insert(files, f)
        end
    end
    if #files == 0 then return end

    local lines = {}
    for _, f in ipairs(files) do
        table.insert(lines, vim.fn.fnamemodify(f, ":~:."))
    end

    list_float("Recent Files", lines, function(lnum)
        if files[lnum] then vim.cmd.edit(files[lnum]) end
    end)
end)


-- Diagnostics picker
vim.keymap.set("n", "<leader>fd", function()
    local diags = vim.diagnostic.get(nil)
    if #diags == 0 then
        vim.notify("No diagnostics", vim.log.levels.INFO)
        return
    end

    table.sort(diags, function(a, b)
        if a.severity ~= b.severity then return a.severity < b.severity end
        if a.bufnr ~= b.bufnr then return a.bufnr < b.bufnr end
        return a.lnum < b.lnum
    end)

    local severity_labels = { "ERROR", "WARN", "INFO", "HINT" }
    local lines = {}
    for _, d in ipairs(diags) do
        local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(d.bufnr), ":~:.")
        local sev   = severity_labels[d.severity] or "?"
        table.insert(lines, string.format("[%s] %s:%d: %s", sev, fname, d.lnum + 1, d.message))
    end

    list_float("Diagnostics", lines, function(lnum)
        local d = diags[lnum]
        if d then
            vim.api.nvim_set_current_buf(d.bufnr)
            vim.api.nvim_win_set_cursor(0, { d.lnum + 1, d.col })
        end
    end)
end)


-- Git diff (current file)
vim.keymap.set("n", "<leader>gd", function()
    local file = vim.fn.expand("%")
    if file == "" then return end

    local lines = vim.fn.systemlist("git diff HEAD -- " .. vim.fn.shellescape(file))
    if #lines == 0 then
        vim.notify("No changes", vim.log.levels.INFO)
        return
    end

    local buf, win = float({ title = "Git Diff: " .. vim.fn.fnamemodify(file, ":t") })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype   = "diff"

    local function close()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end
    vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<Escape>", close, { buffer = buf, nowait = true })
end)


-- Git blame (current file)
vim.keymap.set("n", "<leader>gb", function()
    local file = vim.fn.expand("%")
    if file == "" then return end

    local lines = vim.fn.systemlist("git blame --date=short " .. vim.fn.shellescape(file))
    if #lines == 0 then
        vim.notify("Not a git file", vim.log.levels.INFO)
        return
    end

    local buf, win = float({ title = "Git Blame: " .. vim.fn.fnamemodify(file, ":t") })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    -- sync to current line
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(win, { cursor_line, 0 })

    local function close()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end
    vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
    vim.keymap.set("n", "<Escape>", close, { buffer = buf, nowait = true })
end)
