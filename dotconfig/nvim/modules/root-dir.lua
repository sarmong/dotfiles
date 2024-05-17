local config = {
  monorepo = {
    command = { "git", "rev-parse", "--show-toplevel" },
    patterns = {
      ".git",
      "Makefile",
      "package-lock.json",
      "yarn.lock",
      ".markdownlint.jsonc",
    },
  },
  module = {
    patterns = {
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
    },
  },
}

local M = {}

M.set_root = function(dir)
  if dir then
    vim.fn.execute("cd " .. vim.fs.normalize(dir))
  end
end

M.get_project_root = function()
  local ok, res = pcall(vim.system, config.monorepo.command, {})
  -- @TODO change root async?
  if ok and res:wait().code == 0 then
    return vim.trim(res:wait().stdout)
  end

  local dir = vim.fs.root(0, config.monorepo.patterns)

  return dir
end

M.get_subpackage_root = function()
  local dir = vim.fs.root(0, config.module.patterns)

  if dir then
    return dir
  end

  -- Will default to project root
  return M.get_project_root()
end

return M
