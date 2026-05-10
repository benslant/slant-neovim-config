-- telescopr-config.lua

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

builtin = require('telescope.builtin')

require('telescope').setup({
	defaults = {
		-- Default configuration for telescope goes here:
		vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
		},
		pickers = {
			live_grep = {
				additional_args = function(opts)
				end
			},
		},
		mappings = {
          n = {
          },
			}
	},
})

local function find_all_files()
  require('telescope.builtin').find_files({
    find_command = { 'rg', '--files', '--hidden', '--no-ignore', '--glob', '!.git' },
    prompt_title = "All Files",
    previewer = false,
  })
end

-- Telescope configuration
vim.keymap.set('n', '<leader>ff', find_all_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })		
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- LSP integration: set keymaps buffer-locally when an LSP client attaches
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Telescope LSP keymaps',
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions,               vim.tbl_extend('force', opts, { desc = 'LSP: Go to definition' }))
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references,                vim.tbl_extend('force', opts, { desc = 'LSP: Find references' }))
    vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations,           vim.tbl_extend('force', opts, { desc = 'LSP: Go to implementation' }))
    vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions,          vim.tbl_extend('force', opts, { desc = 'LSP: Go to type definition' }))
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols,          vim.tbl_extend('force', opts, { desc = 'LSP: Document symbols' }))
    vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, vim.tbl_extend('force', opts, { desc = 'LSP: Workspace symbols' }))
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics,                   vim.tbl_extend('force', opts, { desc = 'LSP: Diagnostics (workspace)' }))
    vim.keymap.set('n', '<leader>fi', builtin.lsp_incoming_calls,            vim.tbl_extend('force', opts, { desc = 'LSP: Incoming calls' }))
    vim.keymap.set('n', '<leader>fo', builtin.lsp_outgoing_calls,            vim.tbl_extend('force', opts, { desc = 'LSP: Outgoing calls' }))
  end,
})
