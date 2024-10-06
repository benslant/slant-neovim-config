-- lsp_attach is where you enable features that only work
-- if there is an language server active in the file
local cmp = require('cmp')
local lsp_zero = require('lsp-zero')
local lsp_attach = function(client, bufnr)
local opts = {buffer = bufnr}
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
end

lsp_zero.extend_lspconfig({
 sign_text = true,
 lsp_attach = lsp_attach,
 capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})

require('lspconfig').gopls.setup({})
require('lspconfig').phpactor.setup({})
require('lspconfig').pyright.setup({})
-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
require('lspconfig').ruff_lsp.setup {
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

