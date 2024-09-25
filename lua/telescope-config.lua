local builtins = require('telescope.builtin')
require('telescope').setup({
	defaults = {
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
            ["<leader>ff"] = builtins.find_files,
            ["<C-p>"] = builtins.git_files,
            ["<leader>fb"] = builtins.buffers,
          },
					i = {
						["<leader>ff"] = builtins.find_files,
            ["<C-p>"] = builtins.git_files,
            ["<leader>fb"] = builtins.buffers
					}
    }
	},
--	pickers = {
--		find_files = {
--			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
--			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
--		},
--	},
})


--local builtin = telescope.builtin
-- Telescope configuration
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})



