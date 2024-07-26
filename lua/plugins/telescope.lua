return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim", },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        },
        { "nvim-telescope/telescope-smart-history.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "kkharji/sqlite.lua" },
    },
    config = function()
        require("custom.telescope")
    end
}
