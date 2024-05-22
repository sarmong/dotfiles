local config = {
  monorepo = {
    patterns = {
      { ".git" },
      { "Makefile", "package-lock.json", "yarn.lock", ".markdownlint.jsonc" },
    },
  },
  module = {
    patterns = {
      { "package.json", "tsconfig.json", "jsconfig.json" },
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

  for _, pattern in ipairs(config.monorepo.patterns) do
    local dir = vim.fs.root(bufnr, pattern)

    if dir then
      return dir
    end
  end
end

M.get_subpackage_root = function(bufnr)
  bufnr = bufnr or 0

  for _, pattern in ipairs(config.module.patterns) do
    local dir = vim.fs.root(bufnr, pattern)

    if dir then
      return dir
    end
  end

  -- Will default to project root
  return M.get_project_root()
end

return M
