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
  local ok, res
  if fn.has("nvim-0.10") then
    -- TODO 0.10 change to async
    ok, res = pcall(vim.system, config.monorepo.command, {})
    if ok and res:wait().code == 0 then
      return res:wait().stdout
    end
  else
    ok, res = pcall(vim.fn.system, config.monorepo.command)
    if ok then
      return res
    end
  end

  local dir = vim.fs.dirname(
    vim.fs.find(
      config.monorepo.patterns,
      { upward = true, stop = vim.loop.os_homedir() }
    )[1]
  )

  return dir
end

M.get_subpackage_root = function()
  local dir = vim.fs.dirname(
    vim.fs.find(
      config.module.patterns,
      { upward = true, stop = vim.loop.os_homedir() }
    )[1]
  )

  if dir then
    return dir
  end

  -- Will default to project root
  return M.get_project_root()
end

return M
