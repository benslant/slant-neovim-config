local nvim_docker = require('nvim-docker')
vim.keymap.set('n', '<leader>C', nvim_docker.containers.list_containers)
