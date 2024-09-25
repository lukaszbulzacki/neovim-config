vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace globaly interactive' })

vim.keymap.set('n', 'B', function() vim.api.nvim_command('normal! ge') end, { desc = 'Backward cursor move at word end' })
--vim.keymap.set('n', '<leader>a', function() vim.api.nvim_command('normal! _') end, { desc = 'Goto begin of line' })
--vim.keymap.set('n', '<leader>z', function() vim.api.nvim_command('normal! $') end, { desc = 'Goto end of line' })

-- vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = 'Open empty tab' })

vim.keymap.set('n', '<leader>bp', ':bprev<cr>', { desc = 'Goto [B]uffer [P]rev' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Goto [B]uffer [N]ext' })

vim.keymap.set('n', '<leader>ee', vim.cmd.Ex, { desc = 'Open file [E]xplor[e]r' })

vim.keymap.set('n', '<leader>v', '^vg_', { desc = 'Mark line without leading/trailing whitespaces' })
