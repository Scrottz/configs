return {
    { "navarasu/onedark.nvim", lazy = false, priority = 1000, config = function() require("onedark").setup({ style = "darker", transparent = true }) end },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() require("tokyonight").setup({ style = "night", transparent = true }) end },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() require("catppuccin").setup({ flavour = "mocha", transparent_background = true }) end },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = function() require("gruvbox").setup({ contrast = "hard" }) end },
    { "rebelot/kanagawa.nvim", priority = 1000, config = function() require("kanagawa").setup({ transparent = true, theme = "wave" }) end },
    { "HiPhish/rainbow-delimiters.nvim", lazy = true, event = "BufReadPost" },
    {
        "petertriho/nvim-scrollbar",
        event = "BufReadPost",
        dependencies = { "lewis6991/gitsigns.nvim" }, -- Hier sagen wir Lazy: Erst Gitsigns, dann Scrollbar
        config = function()
          require("scrollbar").setup({
            handlers = {
              gitsigns = true, -- Das ist der magische Schalter!
            },
          })
        end,
    },
}
