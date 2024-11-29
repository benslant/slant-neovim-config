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
	{'nvim-java/nvim-java'},
	{"nvim-neotest/neotest-python"},
	{"dgrbrady/nvim-docker", dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'}},
	{"3rd/diagram.nvim", dependencies = {"3rd/image.nvim"}},
	{"stevanmilic/nvim-lspimport"},
	{"leoluz/nvim-dap-go"},
  	{"sindrets/diffview.nvim"},
	{"tpope/vim-dadbod"},
  	{
	    "ThePrimeagen/refactoring.nvim",
	    dependencies = {
	      "nvim-lua/plenary.nvim",
	      "nvim-treesitter/nvim-treesitter",
	    },
	    lazy = false,
	    config = function()
	      require("refactoring").setup()
	    end,
	},
	{"kristijanhusak/vim-dadbod-ui"},
	{"folke/trouble.nvim", cmd = "Trouble", opts={}},
	{
	    "iamcco/markdown-preview.nvim",
	    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	    ft = { "markdown" },
	    lazy = true,
	    build = function(plugin) 
				if vim.fn.executable "npx" then
					vim.cmd("!cd".. plugin.dir .. " && cd app && npx --yes yarn install")
				else
				-- vim.cmd [[Lazy markdown-preview.nvim]]
					vim.fn["mkdp#util#install"]()
				end
	    end,
	    init = function()
				if vim.fn.executable "npx" then
					vim.g.mkdp_filetype = { "markdown" }
				end
				vim.g.mkdp_browser = 'firefox'
	    end
	}
})


