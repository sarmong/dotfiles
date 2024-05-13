do
  -- Specifies where to install/use rocks.nvim
  local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")

  -- Set up configuration options related to rocks.nvim (recommended to leave as default)
  local rocks_config = {
    rocks_path = vim.fs.normalize(install_location),
    luarocks_binary = vim.fs.joinpath(install_location, "bin", "luarocks"),
  }

  vim.g.rocks_nvim = rocks_config

  -- Configure the package path (so that plugin code can be found)
  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(
      rocks_config.rocks_path,
      "share",
      "lua",
      "5.1",
      "?",
      "init.lua"
    ),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  -- Configure the C path (so that e.g. tree-sitter parsers can be found)
  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  -- Load all installed plugins, including rocks.nvim itself
  vim.opt.runtimepath:append(
    vim.fs.joinpath(
      rocks_config.rocks_path,
      "lib",
      "luarocks",
      "rocks-5.1",
      "rocks.nvim",
      "*"
    )
  )
end

-- -- If rocks.nvim is not installed then install it!
-- if not pcall(require, "rocks") then
--   local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")
--
--   if not vim.uv.fs_stat(rocks_location) then
--     -- Pull down rocks.nvim
--     vim.fn.system({
--       "git",
--       "clone",
--       "--filter=blob:none",
--       "https://github.com/nvim-neorocks/rocks.nvim",
--       rocks_location,
--     })
--   end
--
--   -- If the clone was successful then source the bootstrapping script
--   assert(
--     vim.v.shell_error == 0,
--     "rocks.nvim installation failed. Try exiting and re-entering Neovim!"
--   )
--
--   vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))
--
--   vim.fn.delete(rocks_location, "rf")
-- end
--
-- local H = {
--   cache = { later_callback_queue = {}, exec_errors = {} },
-- }
--
-- H.now = function(f)
--   local ok, err = pcall(f)
--   if not ok then
--     table.insert(H.cache.exec_errors, err)
--   end
--   H.schedule_finish()
-- end
--
-- H.finish = function()
--   local timer, step_delay = vim.loop.new_timer(), 1
--   local f = nil
--   f = vim.schedule_wrap(function()
--     local callback = H.cache.later_callback_queue[1]
--     if callback == nil then
--       H.cache.finish_is_scheduled, H.cache.later_callback_queue = false, {}
--       -- H.report_errors()
--       return
--     end
--
--     table.remove(H.cache.later_callback_queue, 1)
--     H.now(callback)
--     timer:start(step_delay, 0, f)
--   end)
--   timer:start(step_delay, 0, f)
-- end
-- H.schedule_finish = function()
--   if H.cache.finish_is_scheduled then
--     return
--   end
--   vim.schedule(H.finish)
--   H.cache.finish_is_scheduled = true
-- end
--
-- Later = function(f)
--   table.insert(H.cache.later_callback_queue, f)
--   H.schedule_finish()
-- end
--
-- -- @TODO move to shortcuts
-- function Plugin(spec)
--   if spec[1] then
--     spec.source = spec[1]
--   end
--
--   if spec.depends then
--     for _, dspec in ipairs(spec.depends) do
--       Plugin(dspec)
--     end
--   end
--
--   local git_source = spec.source or spec
--   local name = string.match(git_source, "/(.+)$")
--   cmd.packadd(name)
--   -- cmd("Rocks install " .. name .. " git='" .. git_source .. "'")
--   -- cmd("Rocks packadd " .. name)
--   -- vim.print("installing  " .. name)
--   -- cmd("Rocks")
--
--   -- req("mini.deps").add(spec)
-- end
--
-- -- req("rocks.api").install("folke/which-key.nvim")
-- -- require("rocks.operations").add({ "folke/which-key.nvim" })
--
-- H.now(function()
--   req("plugins")
--   req("plugins.which-key")
--   req("plugins.ui")
--   req("plugins.colorschemes")
--
--   -- req("plugins.languages.cmp")
--   Later(function()
--     req("plugins.navigation.buffers")
--     req("plugins.scroll")
--
--     req("plugins.coding")
--     req("plugins.bqf")
--     req("plugins.navigation")
--     req("plugins.navigation.nvim-tree")
--     req("plugins.languages.formatting")
--     req("plugins.languages.null-ls")
--     --
--     req("plugins.languages.lsp")
--     req("plugins.navigation.telescope")
--     req("plugins.languages.markdown")
--
--     req("plugins.languages.misc")
--     req("plugins.languages.treesitter")
--     req("plugins.git")
--     req("plugins.git.gitsigns")
--     req("plugins.git.octo")
--
--     require("neorg").setup({
--       load = {
--         ["core.defaults"] = {},
--         ["core.concealer"] = {},
--         ["core.ui.calendar"] = {},
--         ["core.export"] = {},
--         ["core.dirman"] = {
--           config = {
--             workspaces = {
--               notes = "~/notes",
--             },
--             default_workspace = "notes",
--           },
--         },
--       },
--     })
--     -- default config
--     require("image").setup({
--       backend = "kitty",
--       integrations = {
--         markdown = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
--         },
--         neorg = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { "norg" },
--         },
--         html = {
--           enabled = false,
--         },
--         css = {
--           enabled = false,
--         },
--       },
--       max_width = nil,
--       max_height = nil,
--       max_width_window_percentage = nil,
--       max_height_window_percentage = 50,
--       window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
--       window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
--       editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
--       tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
--       hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
--     })
--   end)
-- end)
