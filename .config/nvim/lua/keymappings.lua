-- ==========================================================================
-- KEYMAPS CONFIGURATION
-- ==========================================================================

local keymap = vim.keymap.set

-- Robust Root Detection using Neovim's native UV (LibUV) API
local function get_project_root()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return vim.fn.getcwd() end
    
    -- Start at the directory of the current file
    local current_dir = vim.fn.fnamemodify(path, ":h")
    local home_dir = vim.loop.os_homedir()

    -- Climb up until we find a root marker or reach the home directory
    while current_dir ~= "" and current_dir ~= home_dir do
        -- Check for .git folder or pyproject.toml file using UV
        local git_stat = vim.loop.fs_stat(current_dir .. "/.git")
        local pyproj_stat = vim.loop.fs_stat(current_dir .. "/pyproject.toml")
        
        if (git_stat and git_stat.type == "directory") or (pyproj_stat and pyproj_stat.type == "file") then
            -- DEBUG: Print the found root to the status line
            print("Project Root Found: " .. current_dir)
            return current_dir
        end
        
        -- Move one level up
        current_dir = vim.fn.fnamemodify(current_dir, ":h")
    end

    print("No root found, falling back to file directory: " .. vim.fn.fnamemodify(path, ":h"))
    return vim.fn.fnamemodify(path, ":h")
end

-- 1. FUZZY FINDER (fzf-lua)
keymap("n", "<leader>ff", function()
    local root = get_project_root()
    require('fzf-lua').files({ cwd = root })
end, { desc = "Find Files (Project Root)", silent = true })

keymap("n", "<leader>fg", function()
    local root = get_/project_root() -- FIX: removed //
    require('fzf-lua').live_grep({ cwd = root })
end, { desc = "Live Grep (Project Root)", silent = true })

keymap("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Find Symbols (Current File)", silent = true })

keymap("n", "<leader>fS", function()
    local root = get_project_root()
    require('fzf-lua').lsp_workspace_symbols({ cwd = root })
end, { desc = "Find Symbols (Project Root)", silent = true })

-- 2. GENERAL UTILITIES
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

