return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        -- bg = '#2E2E2E',
        bg = "#292D38",
        yellow = "#DCDCAA",
        dark_yellow = "#D7BA7D",
        cyan = "#4EC9B0",
        green = "#608B4E",
        light_green = "#B5CEA8",
        string_orange = "#CE9178",
        orange = "#FF8800",
        purple = "#C586C0",
        magenta = "#D16D9E",
        grey = "#858585",
        blue = "#569CD6",
        vivid_blue = "#4FC1FF",
        light_blue = "#9CDCFE",
        red = "#D16969",
        error_red = "#F44747",
        info_yellow = "#FFCC66",
      }

      req("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function()
                return " "
              end,
              padding = 0,
            },
          },
          lualine_b = {
            { "branch", icon = " " },
            {
              "diff",
              symbols = {
                added = "  ",
                modified = " 柳",
                removed = "  ",
              },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              -- displays diagnostics from defined severity
              sections = { "error", "warn", "info", "hint" },
              symbols = {
                error = "  ",
                warn = "  ",
                info = "  ",
                hint = "  ",
              },
              diagnostics_color = {
                -- Same values like general color option can be used here.
                error = { fg = colors.error_red }, -- changes diagnostic's error color
                warn = { fg = colors.orange }, -- changes diagnostic's warn color
                info = { fg = colors.info_yellow }, -- changes diagnostic's info color
                hint = { fg = colors.vivid_blue }, -- changes diagnostic's hint color
              },
              colored = true, -- displays diagnostics status in color if set to true
              update_in_insert = false, -- Update diagnostics in insert mode
              always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              path = 1,
              shorting_target = 40, -- Shortens path to leave 40 spaces in the window for other components
              symbols = {
                modified = "[+]", -- Text to show when the file is modified.
                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
              },
            },
          },

          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        -- in inactive tab
        inactive_sections = {
          lualine_a = {
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              path = 1,
              shorting_target = 0, -- Shortens path to leave 40 spaces in the window for other components
              symbols = {
                modified = "[+]", -- Text to show when the file is modified.
                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
              },
            },
          },
          lualine_b = {},
          lualine_c = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      local startify_config = req("alpha.themes.startify")

      local session_file = "./Session.vim"

      local function file_exists(path)
        local _, error = vim.loop.fs_stat(path)
        return error == nil
      end

      local top_buttons = {
        type = "group",
        val = {
          file_exists(session_file) and startify_config.button(
            "r",
            "Restore previous session",
            "<cmd>source " .. session_file .. "<CR>"
          ) or nil,
          startify_config.button("e", "New file", "<cmd>ene <CR>"),
        },
      }

      local config = {
        layout = {
          { type = "padding", val = 1 },
          startify_config.section.header,
          { type = "padding", val = 2 },
          top_buttons,
          startify_config.section.mru_cwd,
          startify_config.section.mru,
          { type = "padding", val = 1 },
          startify_config.section.bottom_buttons,
          startify_config.section.footer,
        },
        opts = {
          margin = 3,
          redraw_on_resize = false,
          setup = function()
            vim.cmd([[
            autocmd alpha_temp DirChanged * lua req('alpha').redraw()
            ]])
          end,
        },
      }

      req("alpha").setup(config)

      map("n", "<leader>;", req("alpha").start, { desc = "home screen" })
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      { input = { insert_only = false } },
    },
  },
  { "Pocco81/TrueZen.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
      exclude = {
        buftypes = { "terminal" },
        filetypes = {
          "man",
          "help",
          "alpha",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "qf",
        },
      },
      scope = {
        enabled = true,
      },
      -- show_current_context_start = true,
    },
    config = function(_, opts)
      req("ibl").setup(opts)

      map("n", "<leader>ai", cmd.bind("IBLToggle"), "[i]ndent-blankline toggle")
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      -- -- Option 2: nvim lsp as LSP client
      -- -- Tell the server the capability of foldingRange,
      -- -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true,
      -- }
      -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      -- for _, ls in ipairs(language_servers) do
      --   require("lspconfig")[ls].setup({
      --     capabilities = capabilities,
      --     -- you can add other fields for setting up lsp server in this table
      --   })
      -- end
      -- require("ufo").setup()
      -- --

      -- Option 3: treesitter as a main provider instead
      -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      -- use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}