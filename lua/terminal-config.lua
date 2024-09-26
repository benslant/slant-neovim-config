-- Terminal configuration

local term_buf = nil
local term_win = nil

function TermToggle(height)
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.cmd("hide")
	else
		vim.cmd("botright new")
		local new_buf = vim.api.nvim_get_current_buf()
		vim.cmd("resize " .. height)
		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			vim.cmd("buffer " .. term_buf) -- go to terminal buffer
			vim.cmd("bd " .. new_buf) -- cleanup new buffer
		else
			vim.cmd("terminal")
			term_buf = vim.api.nvim_get_current_buf()
			vim.wo.number = false
			vim.wo.relativenumber = false
			vim.wo.signcolumn = "no"
		end
	vim.cmd("startinsert!")
	term_win = vim.api.nvim_get_current_win()
	end
end


vim.keymap.set('t', '<esc>', "<C-\\><C-n>", {})
vim.keymap.set('t', 'A-t', ":lua TermToggle(20)<CR>", {noremap = true, silent = true})
vim.keymap.set('i', 'A-t', "<Esc>:lua TermToggle(20)<CR>", {noremap = true, silent = true})
vim.keymap.set('t', 'A-t', "<C-\\><C-n>:lua TermToggle(20)<CR>", {noremap = true, silent = true})

