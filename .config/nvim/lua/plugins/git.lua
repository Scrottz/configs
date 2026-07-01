return {
  -- 1. Gitsigns: Zeigt Änderungen direkt im Rand der Datei (grün/gelb/rot)

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre", -- Lädt beim Öffnen einer Datei
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '≃' },
        },
        current_line_blame = true, -- Zeigt dir am Ende der Zeile, wer sie zuletzt geändert hat
      })
    end,
  },

  -- 2. Fugitive: Der Klassiker für :Git Befehle
  { "tpope/vim-fugitive" },

  -- 3. LazyGit: Visuelles Git-Interface für NVIM
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Mit <leader>gg öffnest du LazyGit.
      -- Falls du kein Leader-Key definiert hast, nimm einfach "gg"
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
}
