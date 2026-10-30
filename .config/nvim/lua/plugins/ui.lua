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
					lualine_z = {
						"location",
						{ "datetime", style = "%H:%M" },
					},
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
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		event = "VeryLazy", -- Load after UI loads for faster startup
		opts = {
			display = {
				theme = "atom", -- Use Atom Dark theme for generated images/icons
				flavor = "dark", -- Explicitly use dark variant
				show_icon = true, -- Show Neovim logo in the small client indicator circle
				show_theme = false, -- Hide theme name in the large image tooltip
			},
			idle_timeout = 120000, -- Switch to "Idling" after 2 minutes (in milliseconds)
			buttons = nil, -- Disable clickable buttons in Rich Presence
			auto_start = true, -- Connect automatically on VimEnter
			blacklist = {
				-- Environment & Secrets
				".env*", -- .env, .env.production, .env.local, .env.staging, etc.
				"*.pem",
				"*.key",
				"*.crt",
				"*.p12",
				"*.pfx", -- Certificates/Keys
				"*.secret*",
				"*.token*",
				"*.cred*", -- Generic secret patterns
				"terraform.tfvars*", -- Terraform variables
				"ansible-vault*", -- Ansible encrypted files
				"*.tmp",
				"*.bak",
				"*.swp",
				"*.swo",
				"*~",
			},
			log_level = "warn", -- Standard log level ("debug" for troubleshooting)
		},
	},
}
