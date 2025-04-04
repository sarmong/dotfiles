local contrib = req("plugins.ide.contrib")

contrib.mason("prettierd", "prettier", "markdownlint")
contrib.ts_parsers("markdown", "markdown_inline")
contrib.formatters({ "markdown", "markdown.mdx" }, { "prettierd", "prettier" })
contrib.null_ls_sources(function()
  req("null-ls").register(
    req("null-ls").builtins.diagnostics.markdownlint.with({
      extra_args = { "--disable", "MD043" },
    })
  )
end)

Plugin("MeanderingProgrammer/render-markdown.nvim")
-- setup later so that cmp is already available
vim.schedule(function()
  require("render-markdown.integ.cmp").setup()
end)

-- {
--   "git@github.com:sarmong/markdown.nvim.git",
--   config = function()
--     require("markdown").setup({})
--   end,
-- },

-- Plugin("jakewvincent/mkdnflow.nvim")
--
-- req("mkdnflow").setup({
--   modules = {
--     bib = true,
--     buffers = false,
--     conceal = true,
--     cursor = true,
--     folds = true,
--     links = true,
--     lists = true,
--     maps = true,
--     paths = true,
--     tables = true,
--     yaml = false,
--     cmp = false,
--   },
--   filetypes = { md = true, rmd = true, markdown = true },
--   create_dirs = true,
--   perspective = {
--     priority = "first",
--     fallback = "current",
--     root_tell = false,
--     nvim_wd_heel = false,
--     update = false,
--   },
--   wrap = false,
--   bib = {
--     default_path = nil,
--     find_in_root = true,
--   },
--   silent = false,
--   cursor = {
--     jump_patterns = nil,
--   },
--   links = {
--     style = "markdown",
--     name_is_source = false,
--     conceal = true,
--     context = 0,
--     implicit_extension = nil,
--     transform_implicit = false,
--     transform_explicit = function(text)
--       text = text:gsub(" ", "-")
--       text = text:lower()
--       text = os.date("%Y-%m-%d_") .. text
--       return text
--     end,
--   },
--   new_file_template = {
--     use_template = false,
--     placeholders = {
--       before = {
--         title = "link_title",
--         date = "os_date",
--       },
--       after = {},
--     },
--     template = "# {{ title }}",
--   },
--   to_do = {
--     symbols = { " ", "⧖", "x" },
--     update_parents = true,
--     -- not_started = " ",
--     -- in_progress = "-",
--     -- complete = "X",
--   },
--   tables = {
--     trim_whitespace = true,
--     format_on_move = true,
--     auto_extend_rows = false,
--     auto_extend_cols = false,
--     style = {
--       cell_padding = 1,
--       separator_padding = 1,
--       outer_pipes = true,
--       mimic_alignment = true,
--     },
--   },
--   yaml = {
--     bib = { override = false },
--   },
--   mappings = {
--     MkdnEnter = { { "n", "v" }, "<CR>" },
--     MkdnTab = false,
--     MkdnSTab = false,
--     MkdnNextLink = { "n", "<Tab>" },
--     MkdnPrevLink = { "n", "<S-Tab>" },
--     MkdnNextHeading = { "n", "]]" },
--     MkdnPrevHeading = { "n", "[[" },
--     MkdnGoBack = { "n", "<BS>" },
--     MkdnGoForward = { "n", "<Del>" },
--     MkdnCreateLink = false, -- see MkdnEnter
--     MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>p" }, -- see MkdnEnter
--     MkdnFollowLink = false, -- see MkdnEnter
--     MkdnDestroyLink = { "n", "<M-CR>" },
--     MkdnTagSpan = { "v", "<M-CR>" },
--     MkdnMoveSource = { "n", "<F2>" },
--     MkdnYankAnchorLink = { "n", "yaa" },
--     MkdnYankFileAnchorLink = { "n", "yfa" },
--     MkdnIncreaseHeading = { "n", "+" },
--     MkdnDecreaseHeading = { "n", "-" },
--     MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
--     MkdnNewListItem = false,
--     MkdnNewListItemBelowInsert = { "n", "o" },
--     MkdnNewListItemAboveInsert = { "n", "O" },
--     MkdnExtendList = false,
--     MkdnUpdateNumbering = { "n", "<leader>nn" },
--     MkdnTableNextCell = { "i", "<Tab>" },
--     MkdnTablePrevCell = { "i", "<S-Tab>" },
--     MkdnTableNextRow = false,
--     MkdnTablePrevRow = { "i", "<M-CR>" },
--     MkdnTableNewRowBelow = { "n", "<leader>ir" },
--     MkdnTableNewRowAbove = { "n", "<leader>iR" },
--     MkdnTableNewColAfter = { "n", "<leader>ic" },
--     MkdnTableNewColBefore = { "n", "<leader>iC" },
--     MkdnFoldSection = false,
--     MkdnUnfoldSection = false,
--   },
-- })

--   "preservim/vim-markdown",
--   enabled = false,
--   dependencies = {
--     "godlygeek/tabular",
--   },
--   init = function()
--     vim.g.vim_markdown_new_list_item_indent = 0
--   end,
-- },
--   "sarmong/headlines.nvim",
--   config = function()
--     -- @TODO fix (See PR)
--     -- require("headlines").setup()
--   end,
-- },

Plugin({
  "iamcco/markdown-preview.nvim",
  hooks = {
    post_install = function(spec)
      system(
        "npx --yes yarn install",
        { cwd = spec.path .. "/app", detach = true }
      )
    end,
  },
})
map("n", "<leader>M", cmd.bind("MarkdownPreviewToogle"), "[M]arkdown preview")

-- set to 1, nvim will open the preview window after entering the markdown buffer
vim.g.mkdp_auto_start = 0

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
-- default: 1
vim.g.mkdp_auto_close = 1

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
-- default: 0
vim.g.mkdp_refresh_slow = 0

-- set to 1, the MarkdownPreview command can be use for all files,
-- by default it can be use in markdown file
-- default: 0
vim.g.mkdp_command_for_global = 0

-- set to 1, preview server available to others in your network
-- by default, the server listens on localhost (127.0.0.1)
-- default: 0
vim.g.mkdp_open_to_the_world = 0

-- use custom IP to open preview page
-- useful when you work in remote vim and preview on local browser
-- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
-- default empty
vim.g.mkdp_open_ip = ""

-- specify browser to open preview page
-- default: ''
vim.g.mkdp_browser = "firefox"

-- set to 1, echo preview page url in command line when open preview page
-- default is 0
vim.g.mkdp_echo_preview_url = 0

-- a custom vim function name to open preview page
-- this function will receive url as param
-- vim.api.nvim_exec(
--   [[
-- function! g:Open_browser(url)
--     silent exec "!firefox --new-window " . a:url . " &"
-- endfunction
-- ]],
--   false
-- )
-- vim.g.mkdp_browserfunc = "g:Open_browser"

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = "middle",
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
}

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/Documents/md.css"

-- use a custom highlight style must absolute path
-- like '/Users/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_highlight_css = ""

-- use a custom port to start server or random for empty
vim.g.mkdp_port = ""

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = "${name}"

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
vim.g.mkdp_filetypes = { "markdown" }
