
-- ==========================================================================
-- LSP CONFIGURATION (0.12+ Native)
-- ==========================================================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Register configurations without enabling them immediately

vim.lsp.config("pyright", {
    cmd = { "/usr/local/bin/pyright-langserver", "--stdio" },
    root_markers = { ".git", "pyproject.toml" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

vim.lsp.config("ruff", {
    cmd = { "/home/keilholz/.local/bin/ruff", "server" },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
})

vim.lsp.enable("pyright", { "python" })
vim.lsp.enable("ruff", { "python" })

-- Dynamic venv injection
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "python",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "pyright" then
            local root = vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]
            local venv = root and root .. "/.venv/bin/python"
            if venv and vim.fn.executable(venv) == 1 then
                client.config.settings.python.pythonPath = venv
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
        end
    end,
})
