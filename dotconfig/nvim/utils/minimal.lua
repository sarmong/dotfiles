local root = vim.fn.fnamemodify("./nvim-debug-home", ":p")

for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins"

local function install_plugin(slug)
  local plugin_name = vim.fs.basename(slug)
  local plugin_path = vim.fs.joinpath(pack_path, "opt", plugin_name)
  if vim.fn.isdirectory(plugin_path) == 0 then
    vim.print("Installing " .. plugin_name .. "...")
    vim
      .system({
        "git",
        "clone",
        "https://github.com/" .. slug .. ".git",
        "--filter=blob:none",
        plugin_path,
      })
      :wait()
  end

  vim.cmd.packadd(plugin_name)
end

install_plugin("nvim-treesitter/nvim-treesitter")
