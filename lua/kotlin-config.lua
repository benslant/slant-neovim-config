-- Kotlin LSP configuration
-- Plugin: AlexandrosAlexiou/kotlin.nvim
-- Uses JetBrains' official kotlin-lsp (installed via Mason)
-- NOTE: kotlin-lsp is currently pre-alpha/experimental - expect rough edges

require("kotlin").setup({
  -- Root markers used to detect a Kotlin project
  root_markers = { "gradlew", ".git", "mvnw", "settings.gradle" },

  -- JDK for symbol resolution (nil = auto-detect from project)
  jdk_for_symbol_resolution = nil,

  -- Path to JRE (nil = use bundled JRE from Mason installation)
  jre_path = nil,

  -- JVM args for the language server (4GB heap recommended)
  jvm_args = { "-Xmx4g" },

  -- Inlay hints configuration
  inlay_hints = {
    enabled = true,
    parameters = true,
    parameters_compiled = true,
    parameters_excluded = false,
    types_property = true,
    types_variable = true,
    function_return = true,
    function_parameter = true,
    lambda_return = true,
    lambda_receivers_parameters = true,
    value_ranges = true,
    kotlin_time = true,
  },
})

-- kotlin.nvim registers and enables kotlin_ls from its own `FileType kotlin`
-- autocmd. When the first Kotlin buffer is opened at startup (`nvim Foo.kt`),
-- vim.v.vim_did_enter is still 0, so vim.lsp.enable() skips the doautoall that
-- attaches already-open buffers and nothing ever attaches to that buffer -
-- definition/references report no servers registered. Re-run the enable once
-- startup has finished so the initial buffer gets a client.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.lsp.is_enabled("kotlin_ls") then
      vim.lsp.enable("kotlin_ls")
    end
  end,
})

-- Kotlin-specific keymaps (active only in .kt files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set('n', '<leader>kf', '<cmd>KotlinFormat<CR>',           vim.tbl_extend('force', opts, { desc = 'Kotlin: Format file' }))
    vim.keymap.set('n', '<leader>ki', '<cmd>KotlinOrganizeImports<CR>',  vim.tbl_extend('force', opts, { desc = 'Kotlin: Organize imports' }))
    vim.keymap.set('n', '<leader>kh', '<cmd>KotlinHintsToggle<CR>',      vim.tbl_extend('force', opts, { desc = 'Kotlin: Toggle diagnostic hints' }))
    vim.keymap.set('n', '<leader>kH', '<cmd>KotlinInlayHintsToggle<CR>', vim.tbl_extend('force', opts, { desc = 'Kotlin: Toggle inlay hints' }))
    vim.keymap.set('n', '<leader>kd', '<cmd>KotlinDecompile<CR>',        vim.tbl_extend('force', opts, { desc = 'Kotlin: Decompile class file' }))
    vim.keymap.set('n', '<leader>kc', '<cmd>KotlinCleanWorkspace<CR>',   vim.tbl_extend('force', opts, { desc = 'Kotlin: Clean LSP workspace cache' }))
  end,
})
