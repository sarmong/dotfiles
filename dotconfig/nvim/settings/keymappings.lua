-- Unmap space and set leader key to space
map("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

map("n", "<C-p>", req("plugins.telescope").oldfiles)

-- better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "w", "<Plug>CamelCaseMotion_w")

-- save doc using Ctrl+s. If this doesn't work add this two lines to bash_profile: (or just the second)
-- bind -r '\C-s'
-- stty -ixon
map("n", "<C-s>", ":update<CR>")
map("i", "<C-s>", "<Esc>:update<CR>")
map("v", "<C-s>", "<Esc>:update<CR>")

map("i", "<C-u>", "<esc>viwUea")

map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "$")

map("n", "s", ":%s//gc<Left><Left><Left>", { silent = false })
map("n", "S", '"hyiw:%s/<C-r>h//gc<left><left><left>', { silent = false })
map("v", "s", ":s//gc<Left><Left><Left>", { silent = false })
map("v", "S", '"hy:%s/<C-r>h//gc<left><left><left>', { silent = false })

map("n", "gx", function()
  local url = fn.expand("<cfile>")
  if url:match("^https?://") then
    vim.loop.spawn("xdg-open", { args = { url } })
  end
end)

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

map("o", "p", "i{")
map("o", "P", "i(")

map("n", "<A-j>", ":MoveLine(1)<CR>")
map("n", "<A-k>", ":MoveLine(-1)<CR>")
map("n", "<A-l>", ":MoveHChar(1)<CR>")
map("v", "<A-j>", ":MoveBlock(1)<CR>")
map("v", "<A-k>", ":MoveBlock(-1)<CR>")
map("n", "<A-h>", ":MoveHChar(-1)<CR>")
map("v", "<A-l>", ":MoveHBlock(1)<CR>")
map("v", "<A-h>", ":MoveHBlock(-1)<CR>")

-- Buffers
map("n", "<C-i>", "<C-i>") -- needed to distinguish tab and c-i in terminals that support it
map("n", "<TAB>", req("plugins.barbar").next)
map("n", "<S-TAB>", req("plugins.barbar").prev)
map("n", "<A-.>", req("plugins.barbar").move_next)
map("n", "<A-,>", req("plugins.barbar").move_prev)
map("n", "<A-p>", req("plugins.barbar").pin)

map("n", "<S-x>", req("plugins.barbar").close)
map("n", "<A-w>", ":w<CR>:BufferClose<CR>")

for i = 1, 9 do
  map("n", "<A-" .. i .. ">", function()
    req("plugins.barbar").go_to(i)
  end)
end

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
