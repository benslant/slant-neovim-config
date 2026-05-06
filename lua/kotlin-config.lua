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
