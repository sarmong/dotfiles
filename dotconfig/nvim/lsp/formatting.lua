require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    -- Use a sub-list to run only the first available formatter
    astro = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    markdown = { { "prettierd", "prettier" } },
    ["markdown.mdx"] = { { "prettierd", "prettier" } },
    vue = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    scss = { { "prettierd", "prettier" } },
    less = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    jsonc = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
    graphql = { { "prettierd", "prettier" } },
    handlebars = { { "prettierd", "prettier" } },
  },

  format_on_save = function(bufnr)
    local config = req("lsp.config")
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if not config.format_on_save or bufname:match("/node_modules/") then
      return
    end

    return { timeout_ms = 500, lsp_fallback = true }
  end,

  formatters = {
    prettierd = {
      prepend_args = { "--prose-wrap=always" },
    },
    shfmt = {
      prepend_args = { "--indent", "2", "--case-indent" },
    },
  },
})
