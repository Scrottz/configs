return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufReadPost", -- Lädt das Plugin sofort, sobald ein Buffer geladen ist
        config = function()
            require("mini.ai").setup({
                -- mini.ai erkennt Funktionen automatisch via Treesitter
                -- 'a' steht für 'around', 'i' für 'inside'
                -- 'f' steht für 'function'
                mappings = {
                    around_next = 'af',
                    inside_next = 'if',
                },
            })
        end,
    },
}
