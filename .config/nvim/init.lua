-- ==========================================================================
-- NEOVIM MAIN ENTRY POINT
-- ==========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load base configuration
require("options")

-- Initialize Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { { import = "plugins" } },
    defaults = { lazy = true },
})

-- Load project modules
require("keymappings")
require("lsp")
require("statusbar")

-- =========================================================================
-- FINAL UI OVERRIDES
-- Enforce settings to prevent plugin overrides
-- =========================================================================
vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
})

vim.cmd("colorscheme onedark")
