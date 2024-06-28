Plugin("stevearc/conform.nvim")

local opts = {
  formatters_by_ft = req("plugins.ide.contrib").state.formatters,

  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if not Pref.ide.format_on_save or bufname:match("/node_modules/") then
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
}
req("conform").setup(opts)

mapl({
  l = {
    F = {
      function()
        local formatted = req("conform").format()
        if formatted then
          print("Formatted")
        else
          print("No formatting provider")
        end
      end,
      "[F]ormat",
      mode = { "n", "v" },
    },

    e = {
      function(silent)
        Pref.ide.format_on_save = true

        if not silent then
          print("Enabled formatting on save")
        end
      end,
      "[e]nable format on save",
    },
    d = {
      function()
        Pref.ide.format_on_save = true
      end,
      "[d]isable format on save",
    },
  },
})
