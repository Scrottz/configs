-- ==========================================================================
-- LSP CONFIGURATION (0.12+ Native)
-- ==========================================================================

-- Registered servers will be picked up from Mason's PATH automatically
vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	root_markers = { ".git", "pyproject.toml" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
})

vim.lsp.enable("pyright", { "python" })
vim.lsp.enable("ruff", { "python" })
