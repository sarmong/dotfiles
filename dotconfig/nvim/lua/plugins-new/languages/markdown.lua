return {
  -- {
  --   "git@github.com:sarmong/markdown.nvim.git",
  --   config = function()
  --     require("markdown").setup({})
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    ft = "markdown",
  },

  {
    "sarmong/headlines.nvim",
    config = function()
      -- @TODO fix (See PR)
      -- require("headlines").setup()
    end,
  },
}
