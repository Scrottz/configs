-- ==========================================================================
-- NEOVIM MAIN ENTRY POINT
-- Initialize plugins, LSP, and core settings in correct order
-- ==========================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("options")
require("plugins")
require("lsp")
require("statusbar")
-- ==========================================================================
-- NATIVE TREE-SITTER CONFIGURATION (Neovim 0.12+)
-- No more nvim-treesitter plugin needed. Using core native API.
-- ==========================================================================

-- 1. Ensure Python parser is installed natively
-- This replaces :TSInstall
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua", "bash", "json", "yaml" },
    callback = function(args)
        local lang = vim.bo.filetype
        -- Native 0.12 way to ensure parser is present
        pcall(vim.treesitter.start) 
    end,
})

-- 2. Force Highlighting for Python
-- This ensures that the core Tree-sitter engine takes over from Regex
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.cmd("syntax off") -- Kill the "Green Mess" (Regex)
        vim.treesitter.start() -- Start the "Modern" Highlighting
    end,
})
-- System integration
vim.opt.clipboard = "unnamedplus"
vim.cmd("colorscheme gruvbox")
