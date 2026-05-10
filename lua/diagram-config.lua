local diagram = require("diagram")

-- Open the D2 diagram under cursor in macOS Preview (bypasses buggy hover tab)
vim.keymap.set("n", "<leader>dv", function()
  local renderer = require("diagram.renderers.d2")
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed

  -- Find the d2 fenced code block under the cursor
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local in_block = false
  local block_start = nil
  local lang = nil
  local source_lines = {}

  for i, line in ipairs(lines) do
    local row = i - 1 -- 0-indexed
    if not in_block then
      local fence_lang = line:match("^%s*```+%s*(%w+)%s*$")
      if fence_lang and fence_lang:lower() == "d2" then
        in_block = true
        block_start = row
        lang = fence_lang
        source_lines = {}
      end
    else
      if line:match("^%s*```+%s*$") then
        -- end of block — check if cursor was inside
        if cursor_row >= block_start and cursor_row <= row then
          break
        end
        in_block = false
        source_lines = {}
      else
        table.insert(source_lines, line)
      end
    end
  end

  if #source_lines == 0 then
    vim.notify("No D2 diagram found at cursor", vim.log.levels.WARN)
    return
  end

  local source = table.concat(source_lines, "\n")
  local opts = { format = "png" }
  local result = renderer.render(source, opts)
  if not result then return end

  local function open_in_preview()
    if vim.fn.filereadable(result.file_path) == 1 then
      vim.fn.jobstart({ "open", "-a", "Preview", result.file_path })
    else
      vim.notify("Diagram render failed", vim.log.levels.ERROR)
    end
  end

  if result.job_id then
    vim.fn.jobwait({ result.job_id }, 10000)
    vim.schedule(open_in_preview)
  else
    open_in_preview()
  end
end, { desc = "Diagram: open D2 under cursor in Preview" })

diagram.setup({
	integrations = {
		require("diagram.integrations.markdown"),
	},
	renderer_options = {
      mermaid = {
        background = nil, -- nil | "transparent" | "white" | "#hex"
        theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
        scale = 1, -- nil | 1 (default) | 2  | 3 | ...
      },
      plantuml = {
        charset = nil,
      },
      d2 = {
        theme_id = nil,
        dark_theme_id = nil,
        scale = nil,
        layout = nil,
        sketch = nil,
      },
    }
})
