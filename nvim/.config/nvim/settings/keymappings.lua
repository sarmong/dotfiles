local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Unmap space and set leader key to space
map("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

-- better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- save doc using Ctrl+s. If this doesn't work add this two lines to bash_profile: (or just the second)
-- bind -r '\C-s'
-- stty -ixon
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<Esc>:w<CR>")
map("v", "<C-s>", "<Esc>:w<CR>")

map("i", "<C-u>", "<esc>viwUea")

map("n", "H", "^")
map("n", "L", "$")

-- turn off search highlights until next search
-- and close quickfix and loclist windows
map("n", "<esc><esc>", ":noh<CR>:ccl<CR>:lcl<CR>")

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

-- @TODO fix this - interferes with visual-multi plugin
-- resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

map("o", "in(", ":<c-u>normal! f(vi(<cr>")
map("o", "il(", ":<c-u>normal! F)vi(<cr>")
map("o", "p", "i{")
map("o", "P", "i(")
map("o", "in(", ":<c-u>normal! f{vi{<cr>")
map("o", "il(", ":<c-u>normal! F}vi{<cr>")

map("n", "<A-j>", ":MoveLine(1)<CR>")
map("n", "<A-k>", ":MoveLine(-1)<CR>")
map("n", "<A-l>", ":MoveHChar(1)<CR>")
map("v", "<A-j>", ":MoveBlock(1)<CR>")
map("v", "<A-k>", ":MoveBlock(-1)<CR>")
map("n", "<A-h>", ":MoveHChar(-1)<CR>")
map("v", "<A-l>", ":MoveHBlock(1)<CR>")
map("v", "<A-h>", ":MoveHBlock(-1)<CR>")

-- When pressing * in visual mode - search for the selected text, and not the word
vim.api.nvim_exec(
  [[
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
]],
  false
)
