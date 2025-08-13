require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "onelight",
        component_separators = "|",
        section_separators = { left = "*", right = "*" },
    },
    sections = {
        lualine_a = {
            { "mode" },
            { "location" },
            {
                "filename",
                file_status = true,
                path = 1,
                shorting_target = 32,
                symbols = {
                    modified = "+",
                    readonly = "",

                }
            },
        },
        lualine_b = {
            {
                "buffers",
                mode = 2,
                hide_filename_extension = true,
                symbols = {
                    modified = "+",
                    alternate_file = "",
                    directory = "",
                }
            }
        },
        lualine_c = {},
        lualine_x = {
            {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = "#ff9e64" },
            }
        },
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
}
