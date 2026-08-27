-- ==========================================================================
-- LSP CONFIGURATION (0.12+ Native)
-- ==========================================================================

local function set_utf16(client)
	client.offset_encoding = "utf-16"
end

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	root_markers = { ".git", "pyproject.toml" },
	on_init = set_utf16,
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
	on_init = set_utf16,
})

vim.lsp.enable("pyright", { "python" })
vim.lsp.enable("ruff", { "python" })
