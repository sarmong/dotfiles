Plugin("nvim-lua/plenary.nvim") -- required by many plugins

Plugin("nvim-tree/nvim-web-devicons")

Plugin({
  source = "sarmong/neoconf.nvim",
  depends = { "neovim/nvim-lspconfig" },
})
req("neoconf").setup()

-- Quality of life improvements --

Plugin("lambdalisue/suda.vim")

Plugin("mbbill/undotree")
map("n", "<leader>u", cmd.bind("UndotreeToggle"), "[u]ndo tree")

Plugin("mtth/scratch.vim")
local cache_dir = os.getenv("XDG_CACHE_HOME")
vim.g.scratch_persistence_file = cache_dir .. "/nvim/scratch_file"

------------------
-- IDE features --
------------------

-- later(function()
--   Plugin({
--     source = "antosha417/nvim-lsp-file-operations",
--     depends = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
--   })
--
--   require("lsp-file-operations").setup({ debug = false })
-- end)

Plugin("Pocco81/TrueZen.nvim")
