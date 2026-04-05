local contrib = req("plugins.ide.contrib")

contrib.mason("copilot-language-server")

contrib.lsp("copilot", function()
  return {
    on_attach = function(_client, bufnr)
      vim.api.nvim_set_hl(0, "ComplHint", { link = "Comment" })

      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

      map({ "n", "i" }, "<C-.>", function()
        if not vim.lsp.inline_completion.get() then
          return "<C-.>"
        end
      end, { buffer = bufnr })

      map({ "n", "i" }, "<M-]>", function()
        vim.lsp.inline_completion.select({ count = 1 })
      end, { buffer = bufnr })
      map({ "n", "i" }, "<M-[>", function()
        vim.lsp.inline_completion.select({ count = -1 })
      end, { buffer = bufnr })
    end,

    handlers = {
      didChangeStatus = function(err, res, _ctx)
        if res.command and res.command.command == "github.copilot.signIn" then
          vim.notify_once(
            res.message .. " Use `:LspCopilotSignIn` to sign in to Copilot",
            vim.log.levels.ERROR
          )
        elseif err or res.kind == "Error" then
          vim.notify_once(
            "Unknown error: " .. res.message,
            vim.log.levels.ERROR
          )
        end
      end,
    },

    settings = { telemetry = { telemetryLevel = "off" } },
  }
end, { auto_enable = false })
