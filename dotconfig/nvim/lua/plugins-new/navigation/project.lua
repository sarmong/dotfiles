return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      local default_config = {
        detection_methods = { "pattern", "lsp" },
        patterns = {
          "package.json",
          ".git",
        },
        show_hidden = true,
      }

      req("project_nvim").setup(default_config)

      req("which-key").register({
        p = {
          name = "project",
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
      }, { prefix = "<leader>" })
    end,
  },
}