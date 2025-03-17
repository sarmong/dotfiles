local contrib = req("plugins.ide.contrib")
local helpers = req("plugins.ide.utils")

contrib.mason(
  "typescript-language-server",
  "prettier",
  "prettierd",
  "vue-language-server",
  "eslint-lsp",
  "astro-language-server"
)
contrib.formatters({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "astro",
}, { "prettierd", "prettier" })
contrib.ts_parsers("javascript", "typescript", "tsx", "jsdoc", "astro")

local get_lsp_root = function(fname)
  return req("modules.root-dir").get_project_root() or vim.fs.dirname(fname)
end

contrib.setup(function()
  Plugin("dmmulroy/ts-error-translator.nvim")
  Plugin("pmizio/typescript-tools.nvim")

  req("ts-error-translator").setup({})

  req("typescript-tools").setup({
    root_dir = get_lsp_root,
    on_attach = function(client, bufnr)
      -- disable formatting with tsserver, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- go_to_source_definition doesn't list .d.ts files
      map(
        "n",
        "gd",
        req("typescript-tools.api").go_to_source_definition,
        { buffer = bufnr }
      )
    end,

    single_file_support = true,

    autostart = not helpers.isVueProject(),
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = {
        "fix_all",
        "add_missing_imports",
        "remove_unused",
        "remove_unused_imports",
        "organize_imports",
      },
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = "auto",
      tsserver_format_options = {
        providePrefixAndSuffixTextForRename = false,
        allowRenameOfImportPath = false,
      },
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = true,
      include_completions_with_insert_text = true,
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = "off",
      -- by default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
      -- JSXCloseTag
      -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
      -- that maybe have a conflict if enable this feature. )
      jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
    },
  })
end)

contrib.lsp("astro")

contrib.lsp("volar", function()
  return {
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "json",
    },

    root_dir = get_lsp_root,

    on_attach = function(client, bufnr)
      -- disable formatting, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,

    autostart = helpers.isVueProject(),
  }
end)

contrib.lsp("eslint", function()
  return {
    -- root_dir = get_lsp_root,
    cmd_env = {
      NODE_OPTIONS = "--max-old-space-size=8192",
    },
    on_attach = function(client, bufnr)
      -- disable formatting, so that null-ls will handle it
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }
end)
