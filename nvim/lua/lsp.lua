local servers = {
    go     = {
        name     = "gopls",
        cmd      = { "gopls" },
        root     = { "go.mod", "go.sum", ".git" },
        settings = {
            gopls = {
                semanticTokens = true,
                hints = {
                    assignVariableTypes    = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes  = true,
                    constantValues         = true,
                    functionTypeParameters = true,
                    parameterNames         = true,
                    rangeVariableTypes     = true,
                },
            }
        }
    },
    c      = { name = "clangd", cmd = { "clangd" }, root = { "Makefile", "compile_commands.json", ".git" } },
    zig    = {
        name     = "zls",
        cmd      = { "zls" },
        root     = { "build.zig", ".git" },
        settings = {
            zls = {
                enable_inlay_hints                  = true,
                inlay_hints_show_builtin            = true,
                inlay_hints_exclude_single_argument = false,
                enable_semantic_tokens              = true,
            }
        }
    },
    python = { name = "pyright", cmd = { "pyright-langserver", "--stdio" }, root = { "pyproject.toml", "setup.py", ".git" } },
}

-- python tools that run alongside pyright
local python_tools = {
    { name = "ruff", cmd = { "ruff", "server" } },
    { name = "ty",   cmd = { "ty", "server" } },
}

for filetype, cfg in pairs(servers) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern  = filetype,
        callback = function(ev)
            vim.lsp.start({
                name     = cfg.name,
                cmd      = cfg.cmd,
                root_dir = vim.fs.root(ev.buf, cfg.root),
                settings = cfg.settings,
            })
        end,
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern  = "python",
    callback = function(ev)
        local root = vim.fs.root(ev.buf, { "pyproject.toml", ".git" })
        for _, tool in ipairs(python_tools) do
            vim.lsp.start({
                name     = tool.name,
                cmd      = tool.cmd,
                root_dir = root,
            })
        end
    end,
})
