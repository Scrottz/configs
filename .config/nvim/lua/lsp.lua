
-- ==========================================================================
-- LSP CONFIGURATION (0.12+ Native)
-- ==========================================================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Register configurations without enabling them immediately
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]),
    capabilities = capabilities,
    settings = { python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } } }
})

vim.lsp.config("ruff", {
    cmd = { "ruff", "server", "--config", vim.fn.expand("~/.config/ruff/ruff.toml") },
    capabilities = capabilities,
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]),
})

-- Enable servers ONLY for Python files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.lsp.enable({ "pyright", "ruff" })
    end,
})

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
