require("gitlinker").setup()

vim.keymap.set('n', '<leader>gy', "<cmd>lua require('gitlinker').link()<cr>", { desc = 'Copy git link (normal)' })
vim.keymap.set('v', '<leader>gy', "<cmd>lua require('gitlinker').link()<cr>", { desc = 'Copy git link (visual selection)' })
vim.keymap.set('n', '<leader>gY', "<cmd>lua require('gitlinker').link({ action = require('gitlinker.actions').open })<cr>", { desc = 'Open git link in browser' })
vim.keymap.set('v', '<leader>gY', "<cmd>lua require('gitlinker').link({ action = require('gitlinker.actions').open })<cr>", { desc = 'Open git link in browser (visual selection)' })
