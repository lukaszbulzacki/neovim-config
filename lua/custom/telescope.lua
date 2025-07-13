local join_path = function(...)
    local is_win = vim.fn.has("win32") == 1
    local sep = is_win and "\\" or "/"
    local args = { ... }
    local parts = { unpack(args, 2, #args) }
    local strp = next(args) ~= nil and args[1] or ""
    for _, v in ipairs(parts) do
        local part = v ~= true and v or sep
        strp = strp .. sep .. part
    end
    return strp
end

local algos_fzy = require "telescope.algos.fzy"
local sorters = require("telescope.sorters")

local data = assert(vim.fn.stdpath "data") --[[@as string]]
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
        file_ignore_patterns = {
            -- "build\\",
            -- "build\\.*",
            -- ".git\\.*",
            -- "build/",
            -- "build/.*",
            -- ".git/.*",
            ".clang-format",
            "compile_flags.txt",
            join_path("build", true),
            join_path("build", ".*"),
            join_path(".git", true),
            join_path(".git", ".*"),
            join_path("lib", true),
            join_path("lib", ".*"),
            join_path("bin", true),
            join_path("bin", ".*"),
            join_path("obj", true),
            join_path("obj", ".*"),
            join_path("cmake", true),
            join_path("cmake", ".*"),
        }
    },
    extensions = {
        wrap_results = true,

        fzf = {},
        history = {
            path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
            limit = 100,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'smart_history')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'harpoon')
pcall(require('telescope').load_extension, 'T1000')

local builtin = require 'telescope.builtin'

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find()
    -- require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    --     winblend = 10,
    --     previewer = true,
    -- })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>;', function()
    local exact_match = function(_, prompt, _, entry)
        if #prompt == 0 then
            return 1
        end

        local display = entry.ordinal

        return display:find(prompt, 1, true) and entry.index or -1
    end
    require('telescope.builtin').current_buffer_fuzzy_find({
        prompt_title = "Current buffer exact",
        sorter = sorters.new {
            scoring_function = exact_match,

            highlighter = function(_, prompt, display)
                return algos_fzy.positions(prompt, display)
            end,
        }
    })
end, { desc = '[;] Search exact in current buffer' })


vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').grep_string,
    { desc = '[S]earch [C]urrent word under cursor' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sw', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, { desc = '[S]earch [W]ord in files by ripgrep' })
