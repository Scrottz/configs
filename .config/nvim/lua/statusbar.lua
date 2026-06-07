-- ==========================================================================
-- STATUSLINE CONFIGURATION
-- Lightweight, zero-plugin status bar for file info and position
-- ==========================================================================

-- Path formatter: Truncate long paths from the front, preserve filename
_G.get_statusline_path = function()
    local path = vim.fn.expand("%:p")
    if path == "" then
        return "[No Name]"
    end

    local max_len = 75
    if #path > max_len then
        return "..." .. string.sub(path, -(max_len - 3))
    end
    return path
end

-- Display statusline always (even with single window)
vim.o.laststatus = 2

-- Status line format: Buffer | Path | Modified | Position | Filetype | Format
vim.o.statusline = table.concat({
    " %n ",                                   -- Buffer number
    " %{%v:lua.get_statusline_path()%} ",    -- Absolute path (truncated)
    " %m ",                                   -- Modified flag [+]
    "%=",                                     -- Right align
    " %l:%c ",                                -- Line:Column
    " %y ",                                   -- Filetype
    " %{&ff} ",                               -- File format (unix/dos/mac)
})

