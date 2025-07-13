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
        },
        lualine_c = {
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
        lualine_x = {
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
