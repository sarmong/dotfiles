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

local luasnip = req("luasnip")

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
