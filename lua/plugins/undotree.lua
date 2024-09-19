local is_win = vim.fn.has("win32") == 1
return {
    "mbbill/undotree",

    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        if (is_win)
        then
            vim.g.undotree_DiffCommand = "FC" -- Needed by "mbbill/undotree" in windows because diff is not pressent
        end
    end
}
