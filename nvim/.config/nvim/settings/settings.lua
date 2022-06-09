DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object"
vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.
vim.o.inccommand = "split" -- Make substitution work in realtime
vim.o.title = true -- shows window title
vim.o.titlestring = "%{split(getcwd(), '/')[-1]}" -- shown only current directory in title
vim.o.wrap = true
vim.opt.whichwrap:append("<,>,[,],h,l") -- move to next line with theses keys
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.colorcolumn = 99999 -- fix indentline for now
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.go.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 3
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.smartindent = true -- Makes indenting smart
vim.wo.number = true -- set numbered lines
vim.wo.relativenumber = true -- set relative number
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.winbar = "%m %f"
end
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 700 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.list = true
vim.o.listchars = "tab:> ,trail:•" -- show dots on trailing spaces
vim.o.virtualedit = "block" -- more consistent cursor in visual block mode

-- vim.o.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
vim.o.guifont = "FiraCode Nerd Font:h17"
-- vim.bo.undofile = true
-- vim.api.nvim_buf_set_option(0, "undofile", true)
vim.o.undofile = true -- persistent undo
vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true -- search becomes case sensitive if contains any capital letters
vim.o.scrolloff = 4 -- padding of 2 lines when scrolling

vim.g.vim_markdown_fenced_languages = { "js=javascript" }

-- set cyrillic letters for normal mode
vim.o.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
