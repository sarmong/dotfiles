local function build_blink(params)
  vim.notify("Building blink.cmp", vim.log.levels.INFO)
  local obj = vim
    .system({ "cargo", "build", "--release" }, { cwd = params.path })
    :wait()
  if obj.code == 0 then
    vim.notify("Building blink.cmp done", vim.log.levels.INFO)
  else
    vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
  end
end

Plugin({
  "saghen/blink.cmp",
  checkout = "v1.0.0",
  hooks = {
    post_install = build_blink,
    post_checkout = build_blink,
  },
})

Plugin("xzbdmw/colorful-menu.nvim")
req("colorful-menu").setup({})

req("blink.cmp").setup({
  enabled = function()
    return not vim.tbl_contains(
      { "NvimTree", "DressingInput" },
      vim.bo.filetype
    )
  end,

  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = "default" },

  signature = { enabled = true },

  completion = {
    documentation = {
      auto_show = false,

      window = {
        border = "single",
      },
    },

    menu = {
      border = "single",
      draw = {
        columns = {
          { "kind_icon" },
          { "label", gap = 1 },
          { "source_name", gap = 1 },
        },
        components = {
          label = {
            text = function(ctx)
              return req("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return req("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },

  snippets = { preset = "luasnip" },

  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    transform_items = function(_, items)
      return vim
        .iter(items)
        :map(function(item)
          item.source_name = "[" .. item.source_name .. "]"
          return item
        end)
        :totable()
    end,
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
      },
    },
  },
  cmdline = {
    completion = { menu = { auto_show = true } },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
