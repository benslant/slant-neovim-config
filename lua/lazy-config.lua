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
	-- rocks.hererocks = false,
	-- rocks.enabled = false,
	{"williamboman/mason.nvim", opts = {
		ensure_installed = {
			"pyright",
		}
	}
	},
	{'vhyrro/luarocks.nvim'},
	{'nvim-tree/nvim-web-devicons', lazy = true },
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'folke/tokyonight.nvim'},
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
	{'nvim-telescope/telescope.nvim', lazy = true, dependencies = { 'nvim-lua/plenary.nvim', }},
	{"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}},
	{"mfussenegger/nvim-dap-python"},
	{"folke/neodev.nvim", opts = {}},
	{'mortepau/codicons.nvim'},
	{'nvim-tree/nvim-tree.lua', lazy = true, dependencies = {'nvim-tree/nvim-web-devicons'}},
	{'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
	{"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter"
		}
	},
	{"nvim-neotest/neotest-python"},
	{"dgrbrady/nvim-docker", dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'}},
	{"3rd/diagram.nvim", dependencies = {"3rd/image.nvim"}},
	{"stevanmilic/nvim-lspimport"},
	{"leoluz/nvim-dap-go"}
})


