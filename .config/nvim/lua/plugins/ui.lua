return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "darker", transparent = true })
			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = "BufReadPost",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", { "diff", symbols = { added = " +", modified = " ~", removed = " -" } } },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "diagnostics", "filetype" },
					lualine_y = {},
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPre",
		config = function()
			local dropbar = require("dropbar")
			dropbar.setup({
				bar = {
					update_interval = 250,
					sources = function(buf, _)
						local sources = require("dropbar.sources")
						-- Nutzt LSP, wenn verfügbar, ansonsten Treesitter (perfekt für dich!)
						return {
							sources.path,
							sources.lsp,
							sources.treesitter,
						}
					end,
				},
				win_configs = {
					border = "rounded",
				},
			})
		end,
	},
}
