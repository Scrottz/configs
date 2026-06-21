--- Template für python files

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufNewFile", {
  pattern = "*.py",
  callback = function()
    local lines = {
      "",
      "def main():",
      "    # Hier koennte Ihre Werbung stehen!",
      "    pass",
      "",
      "if __name__ == '__main__':",
      "    main()"
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.api.nvim_win_set_cursor(0, {2, 4})
  end,
})
