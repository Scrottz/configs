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
                plugins = {
                    spelling = {
                        enabled = true, -- Enable spelling suggestions in the menu
                    },
                },
            })
        end,
    },
    {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufReadPre",
    config = function()
        require("mini.indentscope").setup({
            draw = {
                delay = 100,
                animation = require("mini.indentscope").gen_animation.none(),
            },
            symbol = "│", -- Das Zeichen für die Linie
        })
    end,
    },
 {
        "echasnovski/mini.icons",
        version = false,
        lazy = false, -- Sollte früh geladen werden, damit Icons überall verfügbar sind
        config = function()
            require("mini.icons").setup()
            -- Optional: Falls du möchtest, dass es nvim-web-devicons ersetzt:
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}, -- Lädt mit Standardeinstellungen
        keys = {
            -- Mapping: Leader + xx öffnet die Fehlerliste
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Diagnostics (Trouble)" },
            -- Mapping: Leader + xq öffnet die Quickfix-Liste
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle Quickfix List" },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        lazy = false,
        dependencies = { "lewis6991/gitsigns.nvim" },
        config = function()
          require("scrollbar").setup({
            show = true,
            handlers = {
              gitsigns = true,
              diagnostic = true, -- Für die Fehler/Warnungen
            },
            handle = {
              show = true,
              color = "#808080", -- Dein grauer Slider
            },
            excluded_filetypes = {
              "prompt",
              "TelescopePrompt",
              "noice",
              "NvimTree",
            },
          })
        end
    },
}
