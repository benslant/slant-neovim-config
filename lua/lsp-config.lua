vim.opt.signcolumn = 'yes'
require('java').setup()

-- Set default capabilities for all LSP servers (nvim 0.11+ API)
vim.lsp.config('*', {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities({
      insertReplaceSupport = false,
    })
  ),
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
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

-- gopls (Go)
vim.lsp.config('gopls', {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
vim.lsp.enable('gopls')

-- jdtls (Java)
vim.lsp.config('jdtls', {})
vim.lsp.enable('jdtls')

-- phpactor (PHP)
vim.lsp.config('phpactor', {})
vim.lsp.enable('phpactor')

-- pylsp (Python)
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      configurationSources = { "pycodestyle" },
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = {'W391', 'E501'},
          maxLineLength = 100,
        },
        pylint = {
          enabled = false,
        },
        black = {
          enabled = true,
        },
        mypy = {
          enabled = true,
          extraArgs = {"--ignore-missing-imports"},
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
})
vim.lsp.enable('pylsp')

-- ruff (Python linter/formatter)
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      args = {},
    }
  }
})
vim.lsp.enable('ruff')

-- yamlls (YAML)
vim.lsp.config('yamlls', {
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
        "!Join sequence",
      },
    },
  },
})
vim.lsp.enable('yamlls')

-- nvim-cmp completion setup
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
