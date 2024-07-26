-- return {
--     "EdenEast/nightfox.nvim",
--     config = function()
--         -- vim.cmd([[colorscheme dawnfox]])
--         vim.cmd([[colorscheme dayfox]])
--     end
-- }

-- return {
-- "projekt0n/github-nvim-theme",
-- config = function()
--
-- end
-- }

return {
    "askfiy/visual_studio_code",
    priority = 100,
    config = function()
        require("visual_studio_code").setup({ mode = "light" })
        vim.cmd([[colorscheme visual_studio_code]])
    end,
}

--     "yorickpeterse/nvim-grey",
--     config = function()
--         vim.opt.laststatus = 3
--         vim.cmd([[colorscheme grey]])
--     end
-- }
