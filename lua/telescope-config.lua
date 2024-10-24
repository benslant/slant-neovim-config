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
