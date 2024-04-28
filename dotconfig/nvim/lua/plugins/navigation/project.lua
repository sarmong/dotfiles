return {
  {
    "ahmedkhalf/project.nvim",
    enabled = false,
    config = function()
      local default_config = {
        detection_methods = { "pattern", "lsp" },
        patterns = {
          "package-lock.json",
          "yarn.lock",
          ".git",
          "package.json",
        },
        show_hidden = true,
      }

      req("project_nvim").setup(default_config)
      req("telescope").load_extension("projects")

      mapl({
        p = {
          m = {
            function()
              req("project_nvim").setup(
                vim.tbl_extend("force", default_config, {
                  patterns = {
                    ".git",
                  },
                })
              )
              cmd("e")
            end,
            "monorepo",
          },
          p = {
            function()
              req("project_nvim").setup(
                vim.tbl_extend("force", default_config, {
                  patterns = {
                    "package.json",
                  },
                })
              )
              cmd("e")
            end,
            "package",
          },
        },
      })
    end,
  },
}
