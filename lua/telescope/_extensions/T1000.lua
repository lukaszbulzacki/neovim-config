return require("telescope").register_extension {
    setup = function(ext_config, config)
        -- print(vim.inspect(ext_config))
        -- print(vim.inspect(config))
    end,
    exports = {
        current_buffer_find = require("skynet.T1000").current_buffer_find
    }
}
