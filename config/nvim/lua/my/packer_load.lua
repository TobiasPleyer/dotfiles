local packer_url = "https://github.com/wbthomason/packer.nvim"
local package_home = vim.fn.stdpath("data")
local packer_install_dir = package_home .. "/site/pack/packer/start"
local packer_install_path = packer_install_dir .. "/packer.nvim"

local download_packer = function()
  vim.fn.mkdir(packer_install_dir, "p")
  local out = vim.fn.system(string.format("git clone %s %s", packer_url, packer_install_path))
  print(out)
end

local install_packer = function()
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end
  print "Downloading packer.nvim..."
  download_packer()
  print "( You'll need to restart now )"
  vim.cmd [[qa]]
end

return function()
  if not pcall(require, "packer") then
    install_packer()
    return true
  end
  return false
end
