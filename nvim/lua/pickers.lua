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

-- Single-line git blame: show blame only for the current line (toggleable)
local blame_ns = vim.api.nvim_create_namespace("git_blame_singleline")
local blame_state = {} -- bufnr -> { enabled = bool, augroup = name, last_lnum = n }

local function parse_blame_single(lines)
    local out = { sha = "", author = "", author_time = "", summary = "" }
    for _, l in ipairs(lines) do
        if not out.sha then
            local sha = l:match("^([0-9a-f]+) ")
            if sha then out.sha = sha end
        end
        local a = l:match("^author (.+)")
        if a then out.author = a end
        local at = l:match("^author-time (.+)")
        if at then out.author_time = at end
        local s = l:match("^summary (.+)")
        if s then out.summary = s end
    end
    return out
end

local function set_blame_for_line(bufnr, lnum)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == "" then return end

    local cmd = string.format("git blame --line-porcelain -L %d,%d -- %s", lnum, lnum, vim.fn.shellescape(fname))
    local lines = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 or not lines or #lines == 0 then
        -- clear any mark if git fails for this line
        vim.api.nvim_buf_clear_namespace(bufnr, blame_ns, 0, -1)
        return
    end

    local info = parse_blame_single(lines)
    local sha_short = (info.sha ~= "") and info.sha:sub(1, 8) or "????????"
    local date = ""
    if info.author_time ~= "" then
        local ts = tonumber(info.author_time)
        if ts then date = os.date("%Y-%m-%d", ts) end
    end
    local txt = sha_short .. " " .. (info.author ~= "" and info.author or "?")
    if date ~= "" then txt = txt .. " " .. date end
    if info.summary ~= "" then txt = txt .. " • " .. info.summary end

    -- clear previous and set extmark at this line
    vim.api.nvim_buf_clear_namespace(bufnr, blame_ns, 0, -1)
    pcall(vim.api.nvim_buf_set_extmark, bufnr, blame_ns, lnum - 1, 0, {
        virt_text = { { txt, "Comment" } },
        virt_text_pos = "eol",
        hl_mode = "combine",
    })
    blame_state[bufnr].last_lnum = lnum
end

local function enable_single_blame(bufnr)
    if blame_state[bufnr] and blame_state[bufnr].enabled then return end
    blame_state[bufnr] = blame_state[bufnr] or {}
    local group_name = "git_blame_single_" .. tostring(bufnr)
    -- ensure fresh group
    pcall(vim.api.nvim_del_augroup_by_name, group_name)
    vim.api.nvim_create_augroup(group_name, { clear = true })

    -- Update blame when the cursor holds (after 'updatetime')
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group_name,
        buffer = bufnr,
        callback = function()
            local cur_buf = vim.api.nvim_get_current_buf()
            if cur_buf ~= bufnr then return end
            local lnum = vim.api.nvim_win_get_cursor(0)[1]
            set_blame_for_line(bufnr, lnum)
        end,
    })

    -- Clear the virt-text immediately when moving so stale info isn't visible
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group_name,
        buffer = bufnr,
        callback = function()
            vim.api.nvim_buf_clear_namespace(bufnr, blame_ns, 0, -1)
        end,
    })

    -- Clean up when buffer is unloaded/closed
    vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete", "BufUnload" }, {
        group = group_name,
        buffer = bufnr,
        callback = function()
            pcall(vim.api.nvim_del_augroup_by_name, group_name)
            blame_state[bufnr] = nil
        end,
    })

    blame_state[bufnr].enabled = true
    blame_state[bufnr].augroup = group_name

    -- Show blame for current line immediately (don't wait for CursorHold)
    local lnum = vim.api.nvim_win_get_cursor(0)[1]
    set_blame_for_line(bufnr, lnum)
    vim.notify("Single-line git blame enabled", vim.log.levels.INFO)
end

local function disable_single_blame(bufnr)
    local st = blame_state[bufnr]
    if not st or not st.enabled then return end
    if st.augroup then
        pcall(vim.api.nvim_del_augroup_by_name, st.augroup)
    end
    vim.api.nvim_buf_clear_namespace(bufnr, blame_ns, 0, -1)
    blame_state[bufnr] = nil
    vim.notify("Single-line git blame disabled", vim.log.levels.INFO)
end

local function toggle_single_blame()
    local bufnr = vim.api.nvim_get_current_buf()
    if blame_state[bufnr] and blame_state[bufnr].enabled then
        disable_single_blame(bufnr)
    else
        -- quick check: file must be a git-tracked file (best-effort)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if fname == "" then
            vim.notify("No file", vim.log.levels.INFO)
            return
        end
        local test = vim.fn.systemlist("git ls-files --error-unmatch -- " .. vim.fn.shellescape(fname))
        if vim.v.shell_error ~= 0 then
            vim.notify("Not a git-tracked file", vim.log.levels.INFO)
            return
        end
        enable_single_blame(bufnr)
    end
end

-- Map <leader>gb to toggle single-line blame mode
vim.keymap.set("n", "<leader>gb", toggle_single_blame, { desc = "Toggle single-line git blame" })
