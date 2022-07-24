if not pcall(require, "telescope") then
  return
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua require('my.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if buffer then
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  else
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")

map_tele("<leader>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})
map_tele("<leader>f/", "grep_last_search", {
  layout_strategy = "vertical",
})

-- Files
map_tele("<leader>ft", "git_files")
map_tele("<leader>fg", "live_grep")
map_tele("<leader>fd", "fd")
map_tele("<leader>fs", "fs")

-- connect et al
map_tele("<leader>fc", "edit_project", "connect")
map_tele("<leader>fl", "edit_project", "lugos")
map_tele("<leader>fv", "edit_project", "luftverbund")
-- Telescope Meta
map_tele("<leader>fB", "builtin")

return map_tele
