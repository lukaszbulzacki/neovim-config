if (vim.fn.has("win32") == 1)
then
    vim.g.sqlite_clib_path = "C:/Windows/System32/sqlite3.dll"
end
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.fs,*.fsx,*.fsi",
    command = [[set filetype=fsharp]]
})
