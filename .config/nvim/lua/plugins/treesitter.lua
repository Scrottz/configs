return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- Wir rufen KEINE setup-Funktion auf, um den Predicate-Fehler zu vermeiden.
            -- Wir nutzen das Plugin NUR, um die Parser beim Starten herunterzuladen.
        end,
    }
}

