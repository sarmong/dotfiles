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

M.get_project_root = function(bufnr)
  bufnr = bufnr or 0
  -- @TODO consider pattern first, command second
  local ok, res = pcall(
    vim.system,
    config.monorepo.command,
    { cwd = a.nvim_buf_get_name(bufnr) }
  )
  if ok and res:wait().code == 0 then
    return vim.trim(res:wait().stdout)
  end

  local dir = vim.fs.root(bufnr, config.monorepo.patterns)

  return dir
end

M.get_subpackage_root = function(bufnr)
  bufnr = bufnr or 0
  local dir = vim.fs.root(bufnr, config.module.patterns)

  if dir then
    return dir
  end

  -- Will default to project root
  return M.get_project_root()
end

return M
