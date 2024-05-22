Plugin("lambdalisue/suda.vim")

Plugin("mbbill/undotree")
map("n", "<leader>u", cmd.bind("UndotreeToggle"), "[u]ndo tree")

Plugin("mtth/scratch.vim")
local cache_dir = os.getenv("XDG_CACHE_HOME")
vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"

Plugin("Pocco81/TrueZen.nvim")
Plugin("dstein64/vim-startuptime")

Plugin("ariel-frischer/bmessages.nvim")
req("bmessages").setup()

Plugin("tzachar/highlight-undo.nvim")
req('highlight-undo').setup({ duration = 300, })
