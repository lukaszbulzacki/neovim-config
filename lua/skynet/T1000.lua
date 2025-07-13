local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local finders = require "telescope.finders"
local conf = require("telescope.config").values


local T1000 = {
    name = "T-1000"
}

-- local function say(fmt, ...)
--     print(string.format(T1000.name .. "| " .. fmt, ...))
-- end

T1000.boot = function()
    -- say("Boot status [PERFECT]")
end

T1000.current_buffer_find = function(opts)
    opts.bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(opts.bufnr)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = opts.bufnr })

    local raw_lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
    local lines = {}

    for lidx, line in ipairs(raw_lines) do
        table.insert(lines, {
            lnum = lidx,
            bufnr = opts.bufnr,
            filename = filename,
            text = line
        })
    end
    local ts_ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    if ts_ok then
        filetype = ts_parsers.ft_to_lang(filetype)
    end
    local _, ts_configs = pcall(require, "nvim-treesitter.configs")

    local parser_ok, parser = pcall(vim.treesitter.get_parser, opts.bufnr, filetype)
    local get_query = vim.treesitter.query.get or vim.treesitter.get_query
    local query_ok, query = pcall(get_query, filetype, "highlights")
    if parser_ok and query_ok and ts_ok and ts_configs.is_enabled("highlight", filetype, opts.bufnr) then
        local root = parser:parse()[1]:root()

        local line_highlights = setmetatable({}, {
            __index = function(t, k)
                local obj = {}
                rawset(t, k, obj)
                return obj
            end,
        })

        local get_hl_from_capture = (function()
            return function(q, id)
                return "@" .. q.captures[id]
            end
        end)()

        for id, node in query:iter_captures(root, opts.bufnr, 0, -1) do
            local hl = get_hl_from_capture(query, id)
            if hl and type(hl) ~= "number" then
                local row1, col1, row2, col2 = node:range()

                if row1 == row2 then
                    local row = row1 + 1

                    for index = col1, col2 do
                        line_highlights[row][index] = hl
                    end
                else
                    local row = row1 + 1
                    for index = col1, #lines[row] do
                        line_highlights[row][index] = hl
                    end

                    while row < row2 + 1 do
                        row = row + 1

                        for index = 0, #(lines[row] or {}) do
                            line_highlights[row][index] = hl
                        end
                    end
                end
            end
        end

        opts.line_highlights = line_highlights
    end
    pickers
        .new(opts, {
            prompt_title = "Current Buffer Exact Search",
            finder = finders.new_table {
                results = lines,
                entry_maker = opts.entry_maker or make_entry.gen_from_buffer_lines(opts),
            },
            sorter = sorters.get_substr_matcher(),
            previewr = conf.grep_previewer(opts),
            attach_mappings = function()
                action_set.select:enhance {
                    post = function()
                        local selection = action_state.get_selected_entry()
                        if not selection then
                            return
                        end
                        vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
                    end
                }
                return true
            end,
            push_cursor_on_edit = true,
        }):find()
end

return T1000
