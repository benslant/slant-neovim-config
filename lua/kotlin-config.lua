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

-- kotlin-lsp only supports one editing session per project root. A second nvim
-- opened on the same repo gets "Multiple editing sessions for one workspace are
-- not supported yet" and the server exits during initialize, so the buffer ends
-- up with no client and no visible reason (a unique --system-path does not help;
-- the lock is keyed on the project root). Make that state easy to see.
local function kotlin_lsp_servers()
  -- macOS pgrep cannot print full command lines, so read them from ps.
  local out = vim.fn.systemlist({ "ps", "-ax", "-o", "pid=,command=" })
  if vim.v.shell_error ~= 0 then
    return {}
  end
  local servers = {}
  for _, line in ipairs(out) do
    if line:find("com.jetbrains.ls.kotlinLsp", 1, true) then
      local workspace = line:match("%-%-system%-path=(%S+)")
      table.insert(servers, {
        pid = line:match("^%s*(%d+)"),
        workspace = workspace and vim.fn.fnamemodify(workspace, ":t") or "?",
      })
    end
  end
  return servers
end

vim.api.nvim_create_user_command("KotlinLspStatus", function()
  local clients = vim.lsp.get_clients({ bufnr = 0, name = "kotlin_ls" })
  local lines = {
    ("filetype: %s"):format(vim.bo.filetype == "" and "(none)" or vim.bo.filetype),
    ("kotlin_ls enabled: %s"):format(tostring(vim.lsp.is_enabled("kotlin_ls"))),
    ("clients attached to this buffer: %d"):format(#clients),
  }
  for _, c in ipairs(clients) do
    table.insert(lines, ("  id %d  root %s"):format(c.id, c.root_dir or "?"))
  end
  local servers = kotlin_lsp_servers()
  table.insert(lines, ("kotlin-lsp processes running: %d"):format(#servers))
  for _, s in ipairs(servers) do
    table.insert(lines, ("  pid %s  workspace %s"):format(s.pid, s.workspace))
  end
  if #clients == 0 and #servers > 0 then
    table.insert(lines, "")
    table.insert(lines, "A kotlin-lsp is already running - if it owns this project root,")
    table.insert(lines, "close the other nvim instance editing this repo, then restart nvim.")
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, { desc = "Kotlin: report LSP attach state and running servers" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function(args)
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_loaded(args.buf) then
        return
      end
      if #vim.lsp.get_clients({ bufnr = args.buf, name = "kotlin_ls" }) > 0 then
        return
      end
      vim.notify(
        "kotlin_ls did not attach to this buffer, so navigation will not work.\n"
          .. "Usually another nvim already owns the kotlin-lsp session for this project "
          .. "(only one per project root is allowed).\nRun :KotlinLspStatus for details.",
        vim.log.levels.WARN
      )
    end, 30000)
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
