local T800 = {
    name = "T-800"
}

-- local function say(fmt, ...)
--     print(string.format(T800.name .. "| " .. fmt, ...))
-- end

T800.boot = function()
    -- say("Boot status [PERFECT]")
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            local buf1st_name = vim.F.if_nil(vim.api.nvim_buf_get_name(1), "")

            if string.len(buf1st_name) == 0 then
                return
            end
            local dstat = vim.uv.fs_stat(buf1st_name) or { type = "unknown" }
            if dstat.type ~= "directory" then
                return
            end

            vim.api.nvim_set_option_value("buflisted", false, { scope = "local", buf = 1 })
        end
    })
end

return T800
