return {
    "folke/noice.nvim",
    event = "VeryLazy",

    opts = {
        presets = {
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "15%",
                        },
                        size = {
                            min_width = "80",
                            width = "auto",
                            height = "auto",
                        },
                    },
                },
            },
        },
    },
}
