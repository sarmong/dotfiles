local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- @TODO change loading order to not have this here
vim.g.mapleader = " "

-- Let lazy handle nested directories too (1 level)
local plugins_root = "plugins"
local imports = { { import = plugins_root } }

local plugins_path = vim.fn.stdpath("config") .. "/lua/" .. plugins_root
local dir_iter = vim.fs.dir(plugins_path)
while true do
  local name, type = dir_iter()
  if name == nil then
    break
  end
  if type == "directory" then
    table.insert(imports, { import = plugins_root .. "." .. name })
  end
end

req("lazy").setup(imports, {
  dev = {
    path = "~/docs/tech",
  },
})
