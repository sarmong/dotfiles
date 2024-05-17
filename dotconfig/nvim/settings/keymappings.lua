local colorscheme = req("settings.colorscheme")
local fns = req("modules.functions")

-- Unmap space and set leader key to space
map("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

req("which-key").register({
  a = { name = "[a]ctions" },
  b = { name = "[b]uffer" },
  F = { name = "[F]old" },
  g = { name = "[g]it" },
  l = { name = "[l]sp" },
  m = { name = "[m]arks" },
  p = { name = "[p]roject" },
  r = { name = "[r]efactoring" },
  s = { name = "[s]earch" },
  t = { name = "[t]reesitter" },
  w = { name = "[w]rap" },
  x = { name = "misc" },
}, { prefix = "<leader>" })

map("n", "w", "<Plug>CamelCaseMotion_w")

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
