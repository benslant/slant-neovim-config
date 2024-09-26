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
				"--hidden",
		},
		mappings = {
          n = {
            ["<leader>ff"] = require('telescope.builtin').find_files,
            ["<C-p>"] = builtin.git_files,
            ["<leader>fb"] = builtin.buffers,
          },
			}
	},
--	pickers = {
--		find_files = {
--			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
--			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
--		},
--	},
})


-- Telescope configuration
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
