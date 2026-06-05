-- ==========================================================================
-- PLUGIN MANAGEMENT, THEMES & PARSERS (lazy.nvim)
-- Objective: Manage external plugins and bootstrap the package manager.
-- Includes Tree-sitter for high-performance, AST-based syntax highlighting.
-- ==========================================================================

-- 1. TRANSPARENCY ENFORCER (Autocommand)
-- Enforces absolute terminal transparency and applies custom color overrides.
local function enforce_transparency()
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
    -- Custom bright lime green for strings (cterm 113)
    set_hl(0, "String", { fg = "#98c379", ctermfg = 113 })
end

local group = vim.api.nvim_create_augroup("ThemeTransparency", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = enforce_transparency,
})

-- 2. PLUGIN DEFINITIONS & CONFIGURATION
require("lazy").setup({
-- High-Performance AST Syntax Highlighting (Tree-sitter)
{
    "nvim-treesitter/nvim-treesitter",
    build = function()
                require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        lazy = false,
        priority = 1000,
        config = function()
            local ok, configs = pcall(require, "nvim-treesitter.configs")
            if not ok then return end
            configs.setup({
                ensure_installed = { "python", "lua", "bash", "json", "yaml" },
                sync_install = false,
                highlight{
                    enabe = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- Theme 1: OneDark
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "darker",
                transparent = true,
            })
        end,
    },

    -- Theme 2: TokyoNight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
            })
        end,
    },
}, {
    defaults = { lazy = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin",
                "tohtml", "tutor", "zipPlugin",
            },
        },
    },
})

-- 3. INITIAL COLOR SCHEME ACTIVATION
vim.cmd("colorscheme onedark")

