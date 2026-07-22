-- ==========================================================================
-- CORE NEOVIM OPTIONS & SETTINGS
-- Essential configuration for editor behavior, search, indentation, and UI
-- ==========================================================================

-- LEADER KEY: Space as prefix for custom commands
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.timeoutlen = 300
local opt = vim.opt

-- =========================================================================
-- 1. PERSISTENT UNDO
-- =========================================================================
-- Enable undo history across sessions, stored in dedicated directory
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- =========================================================================
-- 2. VISUAL DISPLAY & NAVIGATION
-- =========================================================================

-- Standard: Absolute numbers
opt.number = true
opt.relativenumber = false

-- Autocmds: Switch between absolute and relative based on mode/focus
local number_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- When leaving insert mode or entering the buffer, show relative numbers
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = number_group,
	callback = function()
		if vim.api.nvim_get_mode().mode ~= "i" then
			opt.relativenumber = true
		end
	end,
})

-- When entering insert mode or leaving the buffer, show absolute numbers
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = number_group,
	callback = function()
		opt.relativenumber = false
	end,
})

opt.cursorline = true
opt.ruler = true
opt.backspace = "indent,eol,start"
-- =========================================================================
-- 3. SEARCH BEHAVIOR
-- =========================================================================
-- Highlight search matches and show results while typing
opt.hlsearch = true
opt.incsearch = true

-- Smart case: ignore case unless uppercase letters are used
opt.ignorecase = true
opt.smartcase = true

-- =========================================================================
-- 4. INDENTATION (PEP 8 Compliant)
-- =========================================================================
-- Use spaces instead of tabs for consistency across systems
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- =========================================================================
-- 5. SYSTEM INTEGRATION & PERFORMANCE
-- =========================================================================
-- Prevent constant disk writes: disable backup and swap files
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- System clipboard integration: yank/paste to system clipboard
vim.opt.clipboard = "unnamedplus"

-- =========================================================================
-- 6. COLOR & TERMINAL SUPPORT
-- =========================================================================
-- 24-bit true color support for modern color schemes
opt.background = "dark"
opt.termguicolors = true

-- =========================================================================
-- 7. CODE FOLDING (Treesitter Powered)
-- =========================================================================
-- Use native Treesitter expressions to determine fold levels
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Keep folds open by default when loading a file
vim.opt.foldlevel = 99
vim.opt.foldenable = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "vim", "markdown", "yaml" },
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})
