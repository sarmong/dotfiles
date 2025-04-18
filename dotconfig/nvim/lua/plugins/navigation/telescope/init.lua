local telescope = lreq("telescope")
local builtins = curry("telescope.builtin")

local get_visual_selection = lreq("utils.get-visual-selection")
local root_dir = lreq("modules.root-dir")

local fns = curry("plugins.navigation.telescope.functions")
local extensions = lreq("plugins.navigation.telescope.extensions")
local opts = lreq("plugins.navigation.telescope.opts")
local multigrep = req("plugins.navigation.telescope.multigrep")

Plugin("nvim-telescope/telescope.nvim")

telescope.setup(
  vim.tbl_extend("force", opts.get(), { extensions = extensions.opts })
)

extensions.setup()

map("n", "<C-p>", fns.oldfiles(), "oldfiles")

map("v", "<leader>st", function()
  fns.text({
    default_text = get_visual_selection()[1],
  })()
end, "selected text")

map("v", "<leader>sT", function()
  fns.text({
    cwd = root_dir.get_project_root(),
    default_text = get_visual_selection()[1],
  })()
end, "selected text")

mapl({
  f = { fns.find_files(), "find_files" },
  s = {
    a = { fns.api(), "api" },
    b = { builtins.buffers(), "buffers" },
    B = { fns.text_in_open_buffers(), "text in open [B]uffers" },
    c = { builtins.command_history(), "history" },
    d = { builtins.diagnostics({ bufnr = 0 }), "document_diagnostics" },
    D = { builtins.diagnostics(), "workspace_diagnostics" },
    f = { fns.find_files(), "files" },
    F = {
      fns.find_files({ cwd = root_dir.get_project_root() }),
      "files in root",
    },
    g = { builtins.git_status(), "git status" },
    h = { builtins.help_tags(), "vim help" },
    H = { telescope.extensions.helpgrep.helpgrep, "vim helpgrep" },
    i = { ":Telescope media_files<cr>", "media files" },
    m = { builtins.marks(), "marks" },
    M = { multigrep, "multigrep" },
    -- M = { builtins.man_pages(), "man_pages" },
    o = { builtins.vim_options(), "vim_options" },
    t = { fns.text(), "text" },
    T = { fns.text({ cwd = root_dir.get_project_root() }), "text in root" },
    w = { fns.word(), "word" },
    W = { fns.word({ cwd = root_dir.get_project_root() }), "word" },
    R = { builtins.registers(), "registers" },
    u = { builtins.colorscheme(), "colorschemes" },
    s = { builtins.resume({ initial_mode = "normal" }), "previous search" },
  },
})
