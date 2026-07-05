return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("fzf-lua").setup({ winopts = { height = 0.85, width = 0.80, preview = { layout = "vertical" } } })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        lazy = false,
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item() else fallback() end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_prev_item() else fallback() end
                    end, { "i", "s" }),
                }),
                sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" } },
            })
            cmp.setup.filetype({ "markdown", "text" }, {
                enabled = false,
            }) 
        end,
    },
}
