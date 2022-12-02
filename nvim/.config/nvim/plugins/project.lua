local project = require("project_nvim")

local default_config = {
  detection_methods = { "pattern", "lsp" },
  patterns = {
    "package.json",
    ".git",
  },
  show_hidden = true,
}

project.setup(default_config)

return {
  use_monorepo = function()
    project.setup(vim.tbl_extend("force", default_config, {
      patterns = {
        ".git",
      },
    }))
  end,
  use_package = function()
    project.setup(vim.tbl_extend("force", default_config, {
      patterns = {
        "package.json",
      },
    }))
  end,
}
