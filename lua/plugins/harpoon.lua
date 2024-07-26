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

        -- Set <space>1..<space>5 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            vim.keymap.set("n", string.format("<leader>%d", idx), function()
                harpoon:list():select(idx)
            end, { desc = "Go to file 1, 2, 3 ... with harpoon" })
        end
    end,
}
