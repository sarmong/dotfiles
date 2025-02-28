local colorscheme = req("settings.colorscheme")
local fns = req("modules.functions")

-- Unmap space and set leader key to space
map("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

map("n", "w", "<Plug>CamelCaseMotion_w")

-- visually select last yanked or pasted text
map("n", "gV", "`[v`]")

-- save doc using Ctrl+s. If this doesn't work add this two lines to bash_profile: (or just the second)
-- bind -r '\C-s'
-- stty -ixon
map("n", "<C-s>", ":update<CR>")
map("i", "<C-s>", "<Esc>:update<CR>")
map("v", "<C-s>", "<Esc>:update<CR>")

map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")

map("n", "s", ":%s//gc<Left><Left><Left>", { silent = false })
map("n", "S", '"hyiw:%s/<C-r>h//gc<left><left><left>', { silent = false })
map("v", "s", ":s//gc<Left><Left><Left>", { silent = false })
map("v", "S", '"hy:%s/<C-r>h//gc<left><left><left>', { silent = false })

-- turn off search highlights until next search
-- and close quickfix and loclist windows
map("n", "<leader>q", ":noh<CR>:ccl<CR>:lcl<CR>")

map("n", "<leader><leader>x", "<cmd>source %<CR>")
map("n", "<leader>x", ":.lua<CR>")
map("v", "<leader>x", ":lua<CR>")

-- Search within visual selection
map("v", "/", "<esc>/\\%V", { silent = false })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("i", "<C-h>", "<C-\\><C-N><C-w>h")
map("i", "<C-j>", "<C-\\><C-N><C-w>j")
map("i", "<C-k>", "<C-\\><C-N><C-w>k")

-- Tab navigation
map("n", "tt", ":tabnew %<CR>")
map("n", "tn", ":tabnext<CR>")
map("n", "tp", ":tabprevious<CR>")
map("n", "td", ":tabclose<CR>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv=gv")
map("x", "J", ":move '>+1<CR>gv=gv")

map("n", "J", function()
  vim.cmd("normal! mzJ")

  local col = vim.fn.col(".")
  local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
  vim.print(context)

  if
    context == ") ."
    or context == ") :"
    or context:match("%( .")
    or context:match(". ,")
    or context:match("%w %.")
  then
    vim.cmd("undojoin | normal! x")
  elseif context == ",)" then
    vim.cmd("undojoin | normal! hx")
  end

  vim.cmd("normal! `z")
end)

map("o", "p", "i{")
map("o", "P", "i(")

local function wrapn(char_l, char_r)
  char_r = char_r or char_l
  return "viw<esc>a" .. char_r .. "<esc>bi" .. char_l .. "<esc>lel"
end

local function wrapv(char_l, char_r)
  char_r = char_r or char_l
  return "<esc>`>a" .. char_r .. "<esc>`<i" .. char_l .. "<esc>gvll"
end

local chars =
  { '"', "'", "`", { "(", ")" }, { "{", "}" }, { "[", "]" }, { "<", ">" } }

for _, char in ipairs(chars) do
  if type(char) == "table" then
    local char_l = char[1]
    local char_r = char[2]
    map("n", "<leader>w" .. char_l, wrapn(char_l, char_r), "wrap in " .. char_l)
    map("n", "<leader>w" .. char_r, wrapn(char_l, char_r), "wrap in " .. char_l)
    map("v", "<leader>w" .. char_l, wrapv(char_l, char_r), "wrap in " .. char_l)
    map("v", "<leader>w" .. char_r, wrapv(char_l, char_r), "wrap in " .. char_l)
  else
    map("n", "<leader>w" .. char, wrapn(char), "wrap in " .. char)
    map("v", "<leader>w" .. char, wrapv(char), "wrap in " .. char)
  end
end

mapl({
  P = { '"_dP', "super paste" },
  h = { "<C-W>s", "split below" },
  v = { "<C-W>v", "split right" },
  k = { "K", "view help" },

  -- Actions
  a = {
    n = { ":set nonumber!<cr>", "line-numbers" },
    r = { ":set norelativenumber!<cr>", "relative line nums" },
    b = { colorscheme.toggle_background, "toggle background" },
    w = { ":setlocal wrap!<cr>", "toggle wrap" },
    s = { fns.toggle_signcolumn, "toggle signcolumn" },
    f = { fns.toggle_foldcolumn, "toggle foldcolumn" },
  },

  x = {
    x = { "<:!chmod +x %<CR>", "make executable" },
    c = { ":g/console.log/d<CR>:noh<CR>", "Remove console.logs" },
    i = { "0cwimport<ESC>f=cf(from <ESC>f)x", "change requireJS to ESM" },
  },
})

map("n", "<C-i>", "<C-i>") -- needed to distinguish tab and c-i in terminals that support it
map("n", "<tab>", "<nop>")

-- When pressing * in visual mode - search for the selected text, and not the word
cmd([[
    function! s:VSetSearch()
      let temp = @@
      norm! gvy
      let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
      " Use this line instead of the above to match matches spanning across lines
      "let @/ = '\V' . substitute(escape(@@, '\'), '\_s\+', '\\_s\\+', 'g')
      call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
      let @@ = temp
    endfunction

    vnoremap * :<C-u>call <SID>VSetSearch()<CR>/<CR>
    vnoremap # :<C-u>call <SID>VSetSearch()<CR>?<CR>
  ]])

-- Stolen from https://github.com/neovim/neovim/pull/28630
do
  local function _get_url()
    if vim.bo.filetype == "markdown" then
      local range = vim.api.nvim_win_get_cursor(0)
      vim.treesitter.get_parser():parse(range)
      -- marking the node as `markdown_inline` is required. Setting it to `markdown` does not
      -- work.
      local current_node = vim.treesitter.get_node({ lang = "markdown_inline" })
      while current_node do
        local type = current_node:type()
        if type == "inline_link" or type == "image" then
          local child = assert(current_node:named_child(1))
          return vim.treesitter.get_node_text(child, 0)
        end
        current_node = current_node:parent()
      end
    end
    return vim.fn.expand("<cfile>")
  end
  local function do_open(uri)
    local cmd, err = vim.ui.open(uri)
    local rv = cmd and cmd:wait(1000) or nil
    if cmd and rv and rv.code ~= 0 then
      err = ("vim.ui.open: command %s (%d): %s"):format(
        (rv.code == 124 and "timeout" or "failed"),
        rv.code,
        vim.inspect(cmd.cmd)
      )
    end

    if err then
      vim.notify(err, vim.log.levels.ERROR)
    end
    return err
  end

  local gx_desc =
    "Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)"
  vim.keymap.set({ "n" }, "gx", function()
    local err = do_open(_get_url())
    if err then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end, { desc = gx_desc })
  vim.keymap.set({ "x" }, "gx", function()
    local lines = vim.fn.getregion(
      vim.fn.getpos("."),
      vim.fn.getpos("v"),
      { type = vim.fn.mode() }
    )
    -- Trim whitespace on each line and concatenate.
    local err = do_open(table.concat(vim.iter(lines):map(vim.trim):totable()))
    if err then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end, { desc = gx_desc })
end
