Plugin("mfussenegger/nvim-dap")
Plugin({
  "rcarriga/nvim-dap-ui",
  depends = { "nvim-neotest/nvim-nio" },
})
Plugin("mxsdev/nvim-dap-vscode-js")
Plugin({
  "microsoft/vscode-js-debug",
  hooks = {
    post_install = function(spec)
      system(
        "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        { cwd = spec.path, detach = true, shell = true }
      )
    end,
  },
})

local dap = lreq("dap")
local dapui = lreq("dapui")

dapui.setup()

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.stdpath("data")
    .. "/site/pack/deps/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = {
    -- "pwa-node",
    "pwa-chrome",
    -- "pwa-msedge",
    -- "node-terminal",
    -- "pwa-extensionHost",
  }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}) do
  dap.configurations[language] = {
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach",
      address = "...",
      -- processId = req("dap.utils").pick_process,
      -- cwd = "${workspaceFolder}",
    },
  }
end

-- dap.adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "${port}",
--   executable = {
--     command = "node",
--     -- 💀 Make sure to update this path to point to your installation
--     args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
--   },
-- }

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

mapl({
  d = {
    t = { dap.toggle_breakpoint },
    c = { dap.continue },
  },
})
