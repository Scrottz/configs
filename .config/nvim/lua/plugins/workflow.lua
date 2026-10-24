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
		lazy = false,
		config = function()
			require("mini.icons").setup({
				use_file_icons = true,
				use_dir_icons = true,
			})
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
        event = "BufReadPre",
        dependencies = { "lewis6991/gitsigns.nvim" },
        config = function()
            -- 1. Core Scrollbar Setup (UI only)
            require("scrollbar").setup({
                show = true,
                handle = {
                    show = true,
                    -- Use highlight group instead of hardcoded color for theme compatibility
                    highlight = "ScrollbarHandle",
                },
                marks = {
                    Search = { highlight = "Search" },
                    Error = { highlight = "DiagnosticError" },
                    Warn = { highlight = "DiagnosticWarn" },
                    Info = { highlight = "DiagnosticInfo" },
                    Hint = { highlight = "DiagnosticHint" },
                },
                excluded_filetypes = {
                    "prompt",
                    "TelescopePrompt",
                    "noice",
                    "neo-tree",
                    "oil",
                    "dropbar_menu",
                },
                excluded_buftypes = { "terminal", "nofile" },
            })

            -- 2. Register Handlers separately (Required in v2 API)
            -- GitSigns Handler: Shows added/changed/deleted marks
            local ok_gitsigns, gitsigns_handler = pcall(require, "scrollbar.handlers.gitsigns")
            if ok_gitsigns then
                gitsigns_handler.setup()
            end

            -- Diagnostic Handler: Shows error/warn marks
            local ok_diag, diag_handler = pcall(require, "scrollbar.handlers.diagnostic")
            if ok_diag then
                diag_handler.setup()
            end

            -- Search Handler: Shows search matches in scrollbar
            local ok_search, search_handler = pcall(require, "scrollbar.handlers.search")
            if ok_search then
                search_handler.setup()
            end
        end,
    },
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "ruff_format" },
					yaml = { "yamlfmt" },
					lua = { "stylua" },
					json = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = true },
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				skip_ts = { "string" },
			})
		end,
	},
}
