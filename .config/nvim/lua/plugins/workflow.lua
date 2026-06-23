return {
    -- 2. mini.comment: Fast commenting with 'gc'
    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufReadPost",
        config = function()
            require("mini.comment").setup()
        end,
    },
    -- 10. which-key: Displays your keymappings when you pause
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                -- Setup is automatic, just loading it is enough
            })
        end,
    },
}
