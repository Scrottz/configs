return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "darker", transparent = true })
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim", lazy = true, event = "BufReadPost" },
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"filename",
							path = 1,
							shorting_target = 40,
						},
						{
							function()
								local navic = require("nvim-navic")
								if navic.is_available() then
									return navic.get_location()
								else
									return ""
								end
							end,
							cond = function()
								return require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						-- Diagnostics hier in X, damit sie genug Platz haben
						{
							"diagnostics",
							sources = { "nvim_diagnostic", "nvim_lsp" },

							-- Displays diagnostics for the defined severity types
							sections = { "warn", "error", "info", "hint" },

							diagnostics_color = {
								-- Same values as the general color option can be used here.
								error = "DiagnosticError", -- Changes diagnostics' error color.
								warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
								info = "DiagnosticInfo", -- Changes diagnostics' info color.
								hint = "DiagnosticHint", -- Changes diagnostics' hint color.
							},
							symbols = { error = "", warn = "", info = "I", hint = "H" },
							colored = true, -- Displays diagnostics status in color if set to true.
							update_in_insert = false, -- Update diagnostics in insert mode.
							always_visible = false,
							colored = true, -- Das aktiviert das automatische Coloring basierend auf deinem Theme
						},
						"encoding",

						{
							"filetype",
							icon_only = true,
							colored = true,
						},
					},
					lualine_y = {
						-- Venv Symbol hier in Y
						{
							function()
								local venv = vim.env.VIRTUAL_ENV
								return venv and "" or ""
							end,
							color = { fg = "#98c379", gui = "bold" },
						},
					},
					lualine_z = { "location" },
				},
			})
		end,
	},

	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("nvim-navic").setup({
				lsp = { auto_attach = true },
				highlight = true,
			})
		end,
	},
}
