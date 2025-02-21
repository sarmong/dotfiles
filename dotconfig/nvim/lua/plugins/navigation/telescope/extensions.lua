local telescope = lreq("telescope")
local lga_actions = lreq("telescope-live-grep-args.actions")
local utils = lreq("plugins.navigation.telescope.utils")

local extension_opts = {}

-- This stuff is needed because setting plugin opts should be done before loading the extension
local extensions = {}
local load_extension = function(ext)
  table.insert(extensions, ext)
end

Plugin("nvim-telescope/telescope-media-files.nvim")
load_extension("media_files")
extension_opts.media_files = {
  -- filetypes whitelist
  -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
  filetypes = { "png", "webp", "jpg", "jpeg" },
  find_cmd = "rg", -- find command (defaults to `fd`)
}

Plugin("nvim-telescope/telescope-project.nvim")
load_extension("project")

Plugin({
  source = "nvim-telescope/telescope-fzf-native.nvim",
  hooks = {
    post_install = function(spec)
      system("make", { cwd = spec.path, detach = true }):wait()
    end,
  },
})
load_extension("fzf")
extension_opts.fzf = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}

Plugin("natecraddock/telescope-zf-native.nvim")
load_extension("zf-native")

Plugin("nvim-telescope/telescope-live-grep-args.nvim")
load_extension("live_grep_args")

extension_opts.live_grep_args = {
  auto_quoting = true, -- If the prompt value does not begin with ', " or - the entire prompt is treated as a single argument
  mappings = {
    n = {
      ["<CR>"] = utils.pick_window_and_edit,
      ["<C-CR>"] = utils.multi_select,
    },
    i = {
      ["<CR>"] = utils.pick_window_and_edit,
      ["<C-CR>"] = utils.multi_select,
      ["<C-o>"] = lga_actions.quote_prompt({
        postfix = ' --iglob "**/',
      }),
    },
  },
  path_display = {
    filename_first = {
      reverse_directories = false,
    },
  },
}

Plugin("catgoose/telescope-helpgrep.nvim")
load_extension("helpgrep")

Plugin("piersolenski/telescope-import.nvim")
load_extension("import")

Plugin("jmacadie/telescope-hierarchy.nvim")
load_extension("hierarchy")
extension_opts.hierarchy = {}

-- Plugin({
--   source = "nvim-telescope/telescope-smart-history.nvim",
--   depends = { "kkharji/sqlite.lua" }, -- Need libsqlite3-dev on debian
-- })
-- load_extension("smart_history")

return {
  opts = extension_opts,

  setup = function()
    for _, extension in ipairs(extensions) do
      telescope.load_extension(extension)
    end
  end,
}
