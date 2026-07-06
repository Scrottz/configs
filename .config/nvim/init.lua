-- ==========================================================================
-- GLOBAL CONFIGURATION
-- ==========================================================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Ensure Git is found and configured correctly for lazy.nvim
-- By explicitly setting clone_method and disabling terminal prompts
vim.g.lazy_git_config = {
	clone_method = "ssh", -- Use SSH for cloning plugins
	git_executable = "/usr/bin/git",
}
vim.env.GIT_TERMINAL_PROMPT = "0" -- Disable Git terminal prompts

-- Ensure Neovim can find executables managed by Mason (like Git)
-- This line is crucial if Git is installed via Mason and not globally in PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- ==========================================================================
-- BASE CONFIGURATION & PLUGIN MANAGER
-- ==========================================================================

-- Load base options first
require("options")

-- Initialize lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- Clone lazy.nvim using SSH
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"ssh://git@github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath) -- Add lazy.nvim to runtimepath

-- Load plugins from the 'plugins' directory
require("lazy").setup({
	spec = { { import = "plugins" } },
	defaults = { lazy = true },
	-- Optionally, configure rocks if needed, but it's not the cause of the git error
	-- rocks = { enabled = false },
})

-- =========================================================================
-- CUSTOM MODULES & FINAL UI OVERRIDES
-- Load other modules and enforce critical settings after plugins initialize.
-- =========================================================================
require("keymappings") -- Load custom keybindings
require("lsp") -- Load LSP configuration
-- require("statusbar") -- Load statusline configuration (if any)

-- Enforce UI settings to prevent plugin overrides
vim.opt.number = true
vim.opt.relativenumber = false -- Explicitly disabled
vim.opt.clipboard = "unnamedplus"

-- Configure diagnostics display: signs, underlines, hide virtual text
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
})

-- Set colorscheme and ColorColumn (vertical line)
vim.cmd("colorscheme onedark")
-- Highlight for the vertical line at column 89 (after 88)
vim.cmd("highlight ColorColumn guibg=#3e4452 guifg=#5c6370")
