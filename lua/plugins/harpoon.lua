local is_harpoon_quick_menu_visible = function()
    local hwins = vim.api.nvim_list_wins()
    local is_harpoon = function(name)
        return name == "Harpoon"
    end
    local make_flat = function(tab)
        if tab ~= nil then
            return vim.iter(tab):flatten():totable()
        end
        return {}
    end
    for _, hwin in ipairs(hwins) do
        local win = vim.api.nvim_win_get_config(hwin)

        if win.relative ~= "" and #(vim.tbl_filter(is_harpoon, make_flat(win.title))) > 0 then
            return true
        end
    end
    return false
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Add file to harpoon" })
        vim.keymap.set("n", "<leader>hh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Show harpoon list" })
        vim.keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
        end, { desc = "Goto prev file in harpoon" })
        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
        end, { desc = "Goto next file in harpoon" })
        vim.keymap.set("n", "<leader>hd", function()
            if is_harpoon_quick_menu_visible() then
                local idx = vim.fn.line(".")
                -- harpoon:list():remove_at(idx)
                table.remove(harpoon:list().items, idx) -- NOTE: This is workaround for line above
                harpoon.ui:close_menu()
                vim.print("Harpoon remove at", idx)
            end
        end, { desc = "Remove file from quick menu at cursor" })
        -- Set <space>1..<space>5 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            vim.keymap.set("n", string.format("<leader>%d", idx), function()
                harpoon:list():select(idx)
            end, { desc = "Go to file 1, 2, 3 ... with harpoon" })
        end
    end,
}
