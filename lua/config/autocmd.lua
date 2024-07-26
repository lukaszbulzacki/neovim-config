local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--     pattern = "*.fs,*.fsx,*.fsi",
--     command = [[set filetype=fsharp]]
-- })
