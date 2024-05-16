-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "astro",
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "eslint",
  "gopls",
  -- "htmx",
  "pylsp",
  "pyright",
  "lua_ls",
  "tsserver",
  "vimls",
  "volar",
}

local function extractNames(tbl)
  local names = {}
  for _, source in ipairs(tbl) do
    table.insert(names, source.name)
  end
  return names
end

if os.getenv("IS_SERVER") then
  return
end

Plugin("williamboman/mason.nvim")
Plugin("williamboman/mason-lspconfig.nvim")
Plugin("WhoIsSethDaniel/mason-tool-installer.nvim")

req("mason-registry").refresh()
req("mason").setup()

local tools = {}
vim.list_extend(tools, servers)
vim.list_extend(tools, extractNames(req("conform").list_all_formatters()))
vim.list_extend(tools, extractNames(req("null-ls").get_sources()))
req("mason-tool-installer").setup({ ensure_installed = tools })
req("mason-tool-installer").run_on_start()

Plugin({
  source = "neovim/nvim-lspconfig",
  depends = {
    "folke/neodev.nvim",
  },
})

Plugin("pmizio/typescript-tools.nvim")

local default_config = req("plugins.languages.lsp.servers.default")

for _, server in ipairs(servers) do
  local ok, server_config =
    pcall(require, "plugins.languages.lsp.servers." .. server)

  -- if file loaded correctly and didn't return a table,
  -- no need to setup with lspconfig, server was already set up in a file
  if not ok or type(server_config) == "table" then
    local config =
      vim.tbl_deep_extend("force", default_config, ok and server_config or {})

    req("lspconfig")[server].setup(config)
  end
end

autocmd("LspAttach", {
  group = "LspAttachDefault",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    default_config.on_attach(client, ev.buf)
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
Plugin("dmmulroy/ts-error-translator.nvim")
req("ts-error-translator").setup({})

Plugin("scalameta/nvim-metals")
req("plugins.languages.lsp.servers.metals") -- is not in mason

Plugin("j-hui/fidget.nvim")
req("fidget").setup({})
