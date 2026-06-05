-- ==========================================================================
-- NATIVE STATUSLINE CONFIGURATION
-- Objective: Extremely lightweight, zero-plugin status bar with zero overhead.
-- Features: Absolute path display with intelligent front-truncation.
-- ==========================================================================

-- Helper function to get and format the absolute path
-- Truncates the path from the front if it exceeds a defined limit (e.g., 40 chars)
_G.get_statusline_path = function()
    local path = vim.fn.expand("%:p") -- Retrieve absolute path
    if path == "" then
        return "[No Name]"
    end

    -- Define the maximum path length allowed in the statusline
    local max_len = 75

    if #path > max_len then
        -- Cut from the front and prepend '...' to preserve the file name at the end
        return "..." .. string.sub(path, -(max_len - 3))
    end
    return path
end

-- Always display the status line (2 = always)
vim.o.laststatus = 2

-- Define the layout and components of the statusline
vim.o.statusline = table.concat({
    " %n ",                                    -- Buffer number
    " %{%v:lua.get_statusline_path()%} ",      -- Absolute (and truncated) path
    " %m ",                                    -- Modified flag
    "%=",                                      -- Separation point (right-aligns subsequent items)
    " %l:%c ",                                 -- Line number : Column number
    " %y ",                                    -- Filetype of the buffer
    " %{&ff} "                                 -- File format (unix, dos, mac)
})

