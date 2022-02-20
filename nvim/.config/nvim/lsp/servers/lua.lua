local configs = require("lsp.lspconfig")
local lsp_install = require("lsp.lsp-install")

lsp_install("sumneko_lua")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local library = vim.api.nvim_get_runtime_file("", true)
table.insert(library, "/usr/share/nvim/runtime/lua")
table.insert(library, "/usr/share/nvim/runtime/lua/lsp")
table.insert(library, "/usr/share/awesome/lib")

configs.server_opt["sumneko_lua"] = function()
  configs.default_opt.settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "use", "awesome", "client", "root" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
end
