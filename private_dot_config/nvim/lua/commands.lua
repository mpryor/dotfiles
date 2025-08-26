vim.api.nvim_create_user_command('BufDel', function(opts)
    -- Command: BufDel
    -- Arguments: Regex pattern for buffer names
    -- Description: Deletes all buffers matching a pattern
    -- Example: :BufDel .*.py
    local pattern = opts.args
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local matches = string.find(bufname, pattern)
        if matches then
            vim.api.nvim_buf_delete(bufnr, {force=true})
        end
    end
end, { nargs = 1 })
