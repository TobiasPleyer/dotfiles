if require('my.packer_load')() then
  return
end

vim.g.mapleader = ','

--require('my.disable_builtin')
--require('my.globals')
require('my.packer_config')
require('my.telescope')
require('my.telescope.mappings')

vim.cmd [[highlight ColorColumn ctermbg=red]]
vim.cmd [[colorscheme gruvbox]]
