-- ==========================================================================
-- NEOVIM MAIN ENTRY POINT
-- ==========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { { import = "plugins" } },
    defaults = { lazy = true },
})

require("options")
require("keymappings")
require("lsp")
require("statusbar")

vim.opt.clipboard = "unnamedplus"
vim.cmd("colorscheme onedark")
