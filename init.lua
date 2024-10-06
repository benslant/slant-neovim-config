require "lazy-config"
require "nvim-web-devicons"
require "dap-config"
require "nvim-tree-config"
require "lsp-config"
require "telescope-config"
require "lualine-config"
require "terminal-config"
require "neo-test-config"
require "diagram-config"
require "split-navigation-config"
-- require "image-config"
-- require "nvim-docker-config"

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

vim.keymap.set('n', '<Leader>q', ":wqa!\n", {})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')
