Plugin({
  source = "hrsh7th/nvim-cmp",
  depends = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "ray-x/cmp-treesitter",
    "lukas-reineke/cmp-rg",
  },
})

Plugin({
  source = "L3MON4D3/LuaSnip",
  depends = {
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "ChristianChiarulli/html-snippets",
    {
      source = "dsznajder/vscode-es7-javascript-react-snippets",
      hooks = {
        post_install = function(spec)
          system(
            "npx --yes yarn install --frozen-lockfile && npx --yes yarn compile",
            { cwd = spec.path, detach = true, shell = true }
          )
        end,
      },
    },
  },
})

local cmp = req("cmp")
local luasnip = req("luasnip")

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = { completion = { border = "single" } },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ["<C-j>"] = cmp.mapping.select_next_item(),

    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),

    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_locally_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer" },
    -- { name = "cmdline" },
    -- { name = "neorg" },
    -- { name = "rg" },
  }),

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind =
        string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        treesitter = "[TS]",
      })[entry.source.name] or entry.source.name

      return vim_item
    end,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
-- @TODO make it more explicit how the snippets are loaded
req("luasnip.loaders.from_vscode").lazy_load()

local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node
local d = luasnip.dynamic_node
local sn = luasnip.snippet_node

local get_random_color = function()
  local colors = {
    "red",
    "green",
    "yellow",
    "orange",
    "pink",
    "brown",
    "purple",
  }
  return colors[math.random(#colors)]
end

luasnip.add_snippets("javascript", {
  luasnip.snippet(
    "cvv",
    fmt('console.log("%c{}: " + {}, "color: {}")', {
      i(1),
      d(2, function(args)
        return sn(nil, { i(1, args[1]) })
      end, { 1 }),
      d(3, function()
        return sn(nil, { i(1, get_random_color()) })
      end),
    })
  ),
})
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend(
  "typescriptreact",
  { "javascript", "typescript", "javascriptreact" }
)
