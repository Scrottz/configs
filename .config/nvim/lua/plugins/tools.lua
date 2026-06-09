return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("fzf-lua").setup({ winopts = { height = 0.85, width = 0.80, preview = { layout = "vertical" } } })
        end,
    },
    { "neovim/nvim-lspconfig", lazy = false },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "markdown", "text" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({ sources = { null_ls.builtins.diagnostics.vale } })
        end,
    },
}
