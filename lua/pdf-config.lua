-- PDF preview: opens .pdf files as readable text using pdftotext.
-- Requires: brew install poppler

local function fill_buffer(buf, path)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true

  if vim.fn.executable("pdftotext") == 0 then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      "  pdftotext not found.",
      "  Install with:  brew install poppler",
      "",
      "  Press <leader>po to open in macOS Preview instead.",
    })
    vim.bo[buf].modifiable = false
    return
  end

  local lines = vim.fn.systemlist(
    "pdftotext -layout " .. vim.fn.shellescape(path) .. " -"
  )
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].filetype = "text"
  vim.bo[buf].modifiable = false
  vim.cmd("normal! gg")
end

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function(args)
    local path = vim.fn.fnamemodify(args.file, ":p")
    fill_buffer(args.buf, path)
  end,
})

-- Keymaps active whenever a PDF buffer is open
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.pdf",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }

    -- Open in macOS Preview for visual rendering
    vim.keymap.set("n", "<leader>po", function()
      local path = vim.fn.expand("%:p")
      vim.fn.jobstart({ "open", path }, { detach = true })
    end, vim.tbl_extend("force", opts, { desc = "PDF: open in Preview" }))

    -- Reload text content (useful after the PDF is regenerated)
    vim.keymap.set("n", "<leader>pr", function()
      local path = vim.fn.expand("%:p")
      fill_buffer(vim.api.nvim_get_current_buf(), path)
    end, vim.tbl_extend("force", opts, { desc = "PDF: reload text" }))
  end,
})
