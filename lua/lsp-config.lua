vim.opt.signcolumn = 'yes'
require('java').setup()
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities({
		insertReplaceSupport = false,
	})
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

		vim.keymap.set('n', 'K', '<cmd>lua.vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)                           
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('i', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('i', '<leader><TAB>', '<C-x><C-o>', opts)
		vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities({
})

require('lspconfig').gopls.setup({
	--on_attach = on_attach,
	capabilities = capabilities,
	--cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  --root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
require('lspconfig').jdtls.setup({})
require('lspconfig').phpactor.setup({})
require('lspconfig').pyright.setup({
	settings = {
		python = {
			analysis = {
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				stubPath = vim.fn.stdpath("data") .. "/stubs"
			}
		}
	}
})
-- require('lspconfig').kotlin_language_server({})

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
		{name = "luasnip"},
		{name = "buffer"},
		{name = "path"}
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
	},
})

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
require('lspconfig').ruff.setup {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}
require('lspconfig').yamlls.setup({
settings = {
            yaml = {
                    format = {
                            enable = true,
                    },
                    hover = true,
                    completion = true,

                    customTags = {
                    	"!fn",
        		"!And",
        		"!If",
        		"!Not",
        		"!Equals",
        		"!Or",
        		"!FindInMap sequence",
        		"!Base64",
        		"!Cidr",
        		"!Ref",
        		"!Ref Scalar",
        		"!Sub",
        		"!GetAtt",
        		"!GetAZs",
        		"!ImportValue",
        		"!Select",
        		"!Split",
        		"!Join sequence"
                    },
            },
    },
})

