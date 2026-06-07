-- ==========================================================================
-- PLUGIN MANAGEMENT & THEME CONFIGURATION
-- ==========================================================================

-- 1. TRANSPARENCY ENFORCER
local function enforce_transparency()
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
    set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
    set_hl(0, "String", { fg = "#98c379", ctermfg = 113 })
end

local group = vim.api.nvim_create_augroup("ThemeTransparency", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = enforce_transparency,
})

-- 2. PLUGIN DEFINITIONS
require("lazy").setup({
    -- THE MANAGER: We need this plugin ONLY to install and update parsers.
    -- The actual highlighting is handled by the native Neovim 0.12 API.
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        priority = 1000,
        -- We leave config empty because we use the native API in init.lua
    },
    -- Fuzzy Finder: Fast file and symbol navigation
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    height = 0.85,
                    width = 0.80,
                    preview = {
                        layout = "vertical",
                    },
                },
            })
        end,
    },
    -- LSP Bridge
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },

    -- Themes
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function() require("onedark").setup({ style = "darker", transparent = true }) end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function() require("tokyonight").setup({ style = "night", transparent = true }) end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function() require("catppuccin").setup({ flavour = "mocha", transparent_background = true }) end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function() require("gruvbox").setup({ contrast = "hard" }) end,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function() require("kanagawa").setup({ transparent = true, theme = "wave" }) end,
    },
}, {
    defaults = { lazy = true },
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
        },
    },
})
