-- ==========================================================================
-- NEOVIM MAIN ENTRY POINT
-- Order of execution is critical for performance and correct initialization.
-- ==========================================================================

-- 1. BOOTSTRAPPING (Ensure lazy.nvim is available before loading plugins)
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

-- 2. Core System Settings
require("options")

-- 3. Native UI Components
require("statusbar")

-- 4. Plugin Management
require("plugins")

-- 5. FINAL OVERRIDES
-- Ensures clipboard mapping still works after scrabmeling togehter all the other shit
vim.opt.clipboard = "unnamedplus"
