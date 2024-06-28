Plugin("neovim/nvim-lspconfig")

local default_config = req("plugins.ide.utils").get_default_lsp_config
local servers = req("plugins.ide.contrib").state.lsp

for server, server_config in pairs(servers) do
  local config =
    vim.tbl_deep_extend("force", default_config(), server_config() or {})

  req("lspconfig")[server].setup(config)
end

autocmd("LspAttach", {
  group = "LspAttachDefault",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    default_config().on_attach(client, ev.buf)
  end,
})

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  severity_sort = true,
  virtual_text = false,
})

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

mapl({
  l = {
    t = { vim.lsp.buf.type_definition, "go to type definition" },
    r = { vim.lsp.buf.rename, "rename" },
    a = { vim.lsp.buf.code_action, "action" },
    f = { vim.diagnostic.open_float, "open float" },
    Q = { vim.diagnostic.setloclist, "set loc list" },
    v = {
      function()
        vim.diagnostic.config({
          virtual_text = not vim.diagnostic.config().virtual_text,
        })
      end,
      "toggle virtual text",
    },
  },
})

Plugin("j-hui/fidget.nvim")
req("fidget").setup({})
