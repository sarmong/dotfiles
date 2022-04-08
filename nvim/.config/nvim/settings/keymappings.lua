local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Unmap space and set leader key to space
map("n", "<Space>", "<NOP>", { silent = true })
vim.g.mapleader = " "

-- better window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- save doc using Ctrl+s. If this doesn't work add this two lines to bash_profile: (or just the second)
-- bind -r '\C-s'
-- stty -ixon
map("n", "<C-s>", ":w<CR>", { silent = true })
map("i", "<C-s>", "<Esc>:w<CR>", { silent = true })
map("v", "<C-s>", "<Esc>:w<CR>", { silent = true })

map("i", "<C-u>", "<esc>viwUea", { silent = true })

map("n", "H", "^", { silent = true })
map("n", "L", "$", { silent = true })

-- turn off search highlights until next search
map("n", "<esc><esc>", ":noh<CR>", { silent = true })

-- Terminal window navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")
map("i", "<C-h>", "<C-\\><C-N><C-w>h")
map("i", "<C-j>", "<C-\\><C-N><C-w>j")
map("i", "<C-k>", "<C-\\><C-N><C-w>k")
map("i", "<C-l>", "<C-\\><C-N><C-w>l")

-- @TODO fix this - interferes with visual-multi plugin
-- resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- better indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

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
