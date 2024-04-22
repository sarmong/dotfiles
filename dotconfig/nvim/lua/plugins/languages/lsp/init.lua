-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "astro",
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "eslint",
  "gopls",
  "htmx",
  "pylsp",
  "pyright",
  "lua_ls",
  "tsserver",
  "vimls",
  "volar",
}

return {
  {
    "williamboman/mason.nvim",
    cond = not os.getenv("IS_SERVER"),
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function(_, opts)
      req("mason").setup()
      req("mason-lspconfig").setup({ ensure_installed = servers })
      req("mason-tool-installer").setup({ ensure_installed = opts.tools })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    cond = not os.getenv("IS_SERVER"),
    config = function()
      local default_config = req("plugins.languages.lsp.servers.default")

      for _, server in ipairs(servers) do
        local ok, server_config =
          pcall(require, "plugins.languages.lsp.servers." .. server)

        -- if file loaded correctly and didn't return a table,
        -- no need to setup with lspconfig, server was already set up in a file
        if not ok or type(server_config) == "table" then
          local config = vim.tbl_deep_extend(
            "force",
            default_config,
            ok and server_config or {}
          )

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
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    cond = not os.getenv("IS_SERVER"),
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "dmmulroy/ts-error-translator.nvim", opts = {} },
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      req("plugins.languages.lsp.servers.metals") -- is not in mason
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
}
