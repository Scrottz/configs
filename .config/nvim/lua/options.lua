-- ==========================================================================
-- 1. PERSISTENT UNDO
-- Objective: Retain change history even after closing a file. To avoid 
-- cluttering project directories, all undo files are isolated in a 
-- dedicated central directory.
-- ==========================================================================
local opt = vim.opt

opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- ==========================================================================
-- 2. VISUAL DISPLAY & NAVIGATION
-- Objective: Enhance code orientation without visual clutter.
-- 'backspace' is explicitly configured to override legacy Vi restrictions,
-- allowing deletion over line breaks and existing indents like modern editors.
-- ==========================================================================
opt.number = true
opt.cursorline = true
opt.ruler = true
opt.backspace = "indent,eol,start"

-- ==========================================================================
-- 3. SEARCH OPTIMIZATIONS
-- Objective: Fast and flexible search behavior.
-- Combining 'ignorecase' and 'smartcase' ensures searches are case-insensitive
-- by default, but automatically switch to exact-case matching as soon as 
-- an uppercase letter is typed.
-- ==========================================================================
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- ==========================================================================
-- 4. INDENTATION & TABS (PEP 8 & KISS Standard)
-- Objective: Consistent formatting, crucial for Python and config files 
-- (YAML/JSON). Tabs are strictly converted to spaces ('expandtab') to prevent
-- rendering discrepancies across different systems (e.g., GitHub, AWS).
-- ==========================================================================
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- ==========================================================================
-- 5. SYSTEM INTEGRATION & PERFORMANCE
-- Objective: Minimize disk write cycles (critical for older SSDs like the
-- ThinkPad T450s) and ensure smooth OS integration.
-- Disabling backup and swap files prevents constant background disk writes 
-- and keeps project roots clean. 'unnamedplus' links to the system clipboard.
-- ==========================================================================
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.clipboard = "unnamedplus"

-- ==========================================================================
-- 6. COLORS & TERMINAL COMPATIBILITY
-- Objective: Setup for modern color schemes.
-- 'termguicolors' enables 24-bit TrueColor, allowing Neovim to use precise
-- hex colors instead of downscaling them to the terminal's 256-color palette.
-- Highly recommended for modern Tmux configurations.
-- ==========================================================================
opt.background = "dark"
opt.termguicolors = true

