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
					icons_enabled = true,
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_c = {
						"filename",
						{ "diagnostics", sources = { "nvim_lsp" } },
					},
					lualine_x = {
						{
							function()
								-- Sicherheitscheck, ob venv-selector überhaupt geladen ist
								local ok, venv = pcall(require, "venv-selector")
								return ok and venv.get_active_venv() or "No Venv"
							end,
						},
						"encoding",
						"filetype",
					},
				},
			})
		end,
	},
}
