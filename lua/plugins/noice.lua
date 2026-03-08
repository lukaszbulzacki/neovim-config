return {
    "folke/noice.nvim",
    event = "VeryLazy",

    opts = {
        presets = {
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "65%",
                            col = "25%",
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
