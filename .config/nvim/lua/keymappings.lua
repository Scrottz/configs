
-- ==========================================================================
-- KEYMAPS CONFIGURATION
-- ==========================================================================
local keymap = vim.keymap.set

-- 1. LSP MAPPINGS (Now global, active whenever an LSP is attached)
keymap("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition", silent = true })
keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover", silent = true })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol", silent = true })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action", silent = true })

-- 2. FUZZY FINDER (Wrapped in pcall to prevent errors if plugin is lazy-loading)
local function get_project_root()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return vim.fn.getcwd() end
    local current_dir = vim.fn.fnamemodify(path, ":h")
    local home_dir = vim.loop.os_homedir()

    while current_dir ~= "" and current_dir ~= home_dir do
        local git_stat = vim.loop.fs_stat(current_dir .. "/.git")
        local pyproj_stat = vim.loop.fs_stat(current_dir .. "/pyproject.toml")
        if (git_stat and git_stat.type == "directory") or (pyproj_stat and pyproj_stat.type == "file") then
            return current_dir
        end
        current_dir = vim.fn.fnamemodify(current_dir, ":h")
    end
    return vim.fn.fnamemodify(path, ":h")
end

keymap("n", "<leader>ff", function() require('fzf-lua').files({ cwd = get_project_root() }) end, { desc = "Find Files", silent = true })
keymap("n", "<leader>fg", function() require('fzf-lua').live_grep({ cwd = get_project_root() }) end, { desc = "Live Grep", silent = true })
keymap("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Find Symbols (File)", silent = true })
keymap("n", "<leader>fS", function() require('fzf-lua').lsp_workspace_symbols({ cwd = get_project_root() }) end, { desc = "Find Symbols (Root)", silent = true })

-- 3. GENERAL UTILITIES
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search", silent = true })

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Diagnostics
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.jump({count = -1, float = true})<CR>', { desc = "Jump to previous diagnostic" })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.jump({count = 1, float = true})<CR>', { desc = "Jump to next diagnostic" })

-- Folding
keymap("n", "<leader>z", "za", { desc = "Toggle fold" })
keymap("n", "zc", "zC", { desc = "Fold current block" })
