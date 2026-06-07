-- ==========================================================================
-- LANGUAGE SERVER PROTOCOL (LSP) CONFIGURATION
-- Pyright integration for Python type checking and intelligent code analysis
-- Neovim 0.12+ native LSP API
-- ==========================================================================

-- LSP Keybindings: Define keyboard shortcuts for LSP operations
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        desc = "Go to Definition",
        buffer = bufnr,
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        desc = "LSP Hover",
        buffer = bufnr,
    })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
        desc = "LSP Rename Symbol",
        buffer = bufnr,
    })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
        desc = "LSP Code Action",
        buffer = bufnr,
    })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, {
        desc = "Show Diagnostic Error",
        buffer = bufnr,
    })
end

-- Virtual Environment Detection: Locate project-local Python interpreter
local function get_python_path()
    local root = vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]
    if root then
        local venv_python = root .. "/.venv/bin/python"
        if vim.fn.executable(venv_python) == 1 then
            return venv_python
        end
    end
    return nil
end

-- Pyright Configuration: Configure Python language server
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.dirname(
        vim.fs.find({ ".git", "pyproject.toml" }, { upward = true })[1]
    ),
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- Dynamic venv injection: Update Python path when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "pyright" then
            local python_path = get_python_path()
            if python_path then
                client.config.settings.python.pythonPath = python_path
            end
        end
    end,
})

-- Enable Pyright LSP
vim.lsp.enable("pyright")

-- LSP Semantic Token Highlighting: Map LSP types to Gruvbox colors
vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = "#83a598", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = "#83a598", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = "#fabd2f", bold = true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "#d65d0e" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "@lsp.type.keyword", { fg = "#fb4934", bold = true })

