local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	print("Installing lazy.nvim")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("Done")
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'folke/tokyonight.nvim'},
	{"nvim-tree/nvim-web-devicons", lazy = true },
	{"nvim-treesitter/nvim-treesitter", config = function() require("nvim-treesitter.configs").setup {
			highlight = {
				enable = true,
			},
			ensure_installed = {
				"vimdoc",
				"luadoc",
				"vim",
				"lua",
				"markdown"
			}
		}
		end,
	},
	{"nvim-treesitter/nvim-treesitter-textobjects"},
	{'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim', }},
	{"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}},
	{"mfussenegger/nvim-dap-python"},
	{"folke/neodev.nvim", opts = {}},
	{'mortepau/codicons.nvim'},
	{'nvim-tree/nvim-web-devicons'},
	{'nvim-tree/nvim-tree.lua', lazy = true, dependencies = {'nvim-tree/nvim-web-devicons'}},
})


