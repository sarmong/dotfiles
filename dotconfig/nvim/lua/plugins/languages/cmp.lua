return {

  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "ray-x/cmp-treesitter",
      "lukas-reineke/cmp-rg",
    },

    config = function()
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

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = { completion = { border = "single" } },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
    end,
  },
  {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "ChristianChiarulli/html-snippets",
        {
          "dsznajder/vscode-es7-javascript-react-snippets",
          build = "yarn install --frozen-lockfile && yarn compile",
        },
      },
      config = function()
        -- @TODO make it more explicit how the snippets are loaded
        req("luasnip.loaders.from_vscode").lazy_load()

        --Treesitter
        local q = require("vim.treesitter.query")
        local ls = require("luasnip")
        local s = ls.s
        local i = ls.i
        local t = ls.t
        local d = ls.dynamic_node
        local c = ls.choice_node
        local f = ls.function_node
        local sn = ls.snippet_node
        local fmt = require("luasnip.extras.fmt").fmt
        local rep = require("luasnip.extras").rep
        local snippets, autosnippets = {}, {}
        local group =
          vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
        local file_pattern = "*.js"

        local function cs(trigger, nodes, opts)
          local snippet = s(trigger, nodes)
          local target_table = snippets
          local pattern = file_pattern
          local keymaps = {}
          if opts ~= nil then
            -- check for custom pattern
            if opts.pattern then
              pattern = opts.pattern
            end
            -- if opts is a string
            if type(opts) == "string" then
              if opts == "auto" then
                target_table = autosnippets
              else
                table.insert(keymaps, { "i", opts })
              end
            end
            -- if opts is a table
            if opts ~= nil and type(opts) == "table" then
              for _, keymap in ipairs(opts) do
                if type(keymap) == "string" then
                  table.insert(keymaps, { "i", keymap })
                else
                  table.insert(keymaps, keymap)
                end
              end
            end
            -- set autocmd for each keymap
            if opts ~= "auto" then
              for _, keymap in ipairs(keymaps) do
                vim.api.nvim_create_autocmd("BufEnter", {
                  pattern = pattern,
                  group = group,
                  callback = function()
                    vim.keymap.set(keymap[1], keymap[2], function()
                      ls.snip_expand(snippet)
                    end, {
                      noremap = true,
                      silent = true,
                      buffer = true,
                    })
                  end,
                })
              end
            end
          end
          table.insert(target_table, snippet) -- insert snippet into appropriate table
        end

        local function compare_distance(a, b)
          return a[1] < b[1]
        end
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
        local insert_matches = function(
          match_table,
          query_string,
          root,
          cursor_row
        )
          for _, captures, metadata in query_string:iter_matches(root, 0) do
            local match_row = metadata.content[1][1] + 1
            -- Shouldnt be able to console log variables under the cursor
            if (cursor_row - match_row) > 0 then
              local distance = math.abs(cursor_row - match_row)
              table.insert(
                match_table,
                { distance, q.get_node_text(captures[1], 0) }
              )
            end
          end
        end
        local get_variable = function(position)
          return d(position, function()
            local nodes = {}
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local cursor_row = cursor_pos[1]
            local language_tree = vim.treesitter.get_parser(0, "javascript")
            local syntax_tree = language_tree:parse()
            local root = syntax_tree[1]:root()
            local query_string_variables =
              "(variable_declarator name: (identifier) u/name (#offset! u/name))"
            local query_string_parameters =
              "(formal_parameters (identifier) u/identifier (#offset! u/identifier))"
            local query_variables =
              vim.treesitter.parse_query("javascript", query_string_variables)
            local query_parameters =
              vim.treesitter.parse_query("javascript", query_string_parameters)
            local matches = {}
            insert_matches(matches, query_variables, root, cursor_row)
            insert_matches(matches, query_parameters, root, cursor_row)
            table.sort(matches, compare_distance)
            for _, match in ipairs(matches) do
              table.insert(nodes, t(match[2]))
            end
            return sn(nil, c(1, nodes))
          end, {})
        end

        cs(
          "cv",
          fmt([[console.log("%c{}: " + {}, "color: {}")]], {
            rep(1),
            get_variable(1),
            f(function()
              return get_random_color()
            end),
          })
        )
      end,
    },
  },
}
