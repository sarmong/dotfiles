local action_state = lreq("telescope.actions.state")
local builtins = lreq("telescope.builtin")

local root_dir = lreq("modules.root-dir")

local M = {}

local get_relative_path = function(path)
  return path:match("^" .. vim.uv.cwd():gsub("%-", "%%-") .. "/(.+)")
end

local current_prompt_text = function()
  for _, bufnr in ipairs(vim.fn.tabpagebuflist()) do
    if vim.bo[bufnr].filetype == "TelescopePrompt" then
      return action_state.get_current_picker(bufnr):_get_prompt()
    end
  end
  return nil
end

M.oldfiles = function()
  builtins.oldfiles({
    preview = { hide_on_startup = true },
    initial_mode = "normal",
    layout_config = { width = 0.5, height = 0.5 },
  })
end

M.find_files = function(options)
  if vim.bo.filetype ~= "NvimTree" then
    builtins.find_files(vim.tbl_extend("force", {
      hidden = true,
      cwd = root_dir.get_subpackage_root(),
      default_text = current_prompt_text(),
    }, options or {}))
  else
    -- Search inside the focused dir in nvim-tree
    local tree = req("nvim-tree.lib")
    local node = tree.get_node_at_cursor()
    if node then
      builtins.find_files({
        search_dirs = {
          get_relative_path(
            not node.open and node.parent.absolute_path or node.absolute_path
          ),
        },
        hidden = true,
      })
    end
  end
end

M.text = function(options)
  if vim.bo.filetype ~= "NvimTree" then
    req("telescope").extensions.live_grep_args.live_grep_args(
      vim.tbl_extend("force", {
        cwd = root_dir.get_subpackage_root(),
        default_text = current_prompt_text(),
      }, options or {})
    )
  else
    local tree = req("nvim-tree.lib")
    local node = tree.get_node_at_cursor()
    if node then
      req("telescope").extensions.live_grep_args.live_grep_args({
        default_text = current_prompt_text(),
        search_dirs = {
          get_relative_path(
            not node.open and node.parent.absolute_path or node.absolute_path
          ),
        },
      })
    end
  end
end

M.text_in_open_buffers = function()
  builtins.live_grep({
    default_text = current_prompt_text(),
    grep_open_files = true,
  })
end

M.api = function(options)
  local cur_word = current_prompt_text() or vim.fn.expand("<cword>")
  local create_api_name = ""
  if cur_word:match(".*API$") then
    local first = cur_word:sub(1, 1)
    local rest = cur_word:sub(2)
    create_api_name = "create" .. first:upper() .. rest

    local create_api_file = vim.fs.find(
      { create_api_name .. ".ts", create_api_name .. ".tsx" },
      { path = "packages", type = "file" }
    )
    if create_api_file[1] then
      vim.cmd.Pick(create_api_file[1])
      return
    end
  end

  req("telescope").extensions.live_grep_args.live_grep_args(
    vim.tbl_extend("force", {
      default_text = create_api_name,
    }, options or {})
  )
end

M.word = function(options)
  M.text(vim.tbl_extend("force", {
    default_text = vim.fn.expand("<cword>"),
  }, options or {}))
end

return M
