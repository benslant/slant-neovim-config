-- Markdown Preview configuration
-- Plugin: iamcco/markdown-preview.nvim

-- Open preview in browser automatically when entering a markdown buffer
vim.g.mkdp_auto_start = 0

-- Auto-close preview when leaving the markdown buffer
vim.g.mkdp_auto_close = 1

-- Refresh preview only on save or leaving insert mode (0 = refresh on every change)
vim.g.mkdp_refresh_slow = 0

-- Use firefox as the browser (change to 'google-chrome', 'chromium', etc. if preferred)
vim.g.mkdp_browser = 'Google Chrome'

-- Preview page title: uses buffer filename by default
vim.g.mkdp_page_title = '「${name}」'

-- Keymaps for markdown preview (only active in markdown files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set('n', '<Leader>mp', '<Cmd>MarkdownPreview<CR>', vim.tbl_extend('force', opts, { desc = "Start Markdown Preview" }))
    vim.keymap.set('n', '<Leader>ms', '<Cmd>MarkdownPreviewStop<CR>', vim.tbl_extend('force', opts, { desc = "Stop Markdown Preview" }))
    vim.keymap.set('n', '<Leader>mt', '<Cmd>MarkdownPreviewToggle<CR>', vim.tbl_extend('force', opts, { desc = "Toggle Markdown Preview" }))
  end,
})
