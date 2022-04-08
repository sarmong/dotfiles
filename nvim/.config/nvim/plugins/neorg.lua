require("neorg").setup({
  -- Tell Neorg what modules to load
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = { config = { markup_preset = "brave" } }, -- Allows for use of icons
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          my_workspace = "$XDG_NC_DIR/Vault",
        },
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.highlights"] = {},
  },
  hook = function()
    -- This sets the leader for all Neorg keybinds. It is separate from the regular <Leader>,
    -- And allows you to shove every Neorg keybind under one "umbrella".
    local neorg_leader = "<Leader>o" -- You may also want to set this to <Leader>o for "organization"

    -- Require the user callbacks module, which allows us to tap into the core of Neorg
    local neorg_callbacks = require("neorg.callbacks")

    -- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
    -- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
    -- needs to reevaluate all the bound keys is invoked
    neorg_callbacks.on_event(
      "core.keybinds.events.enable_keybinds",
      function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode

            -- Keys for managing TODO items and setting their states
            { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
            { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
            { "gtd", "core.norg.qol.todo_items.todo.task_done" },
            { "gth", "core.norg.qol.todo_items.todo.task_on_hold" },
            { "gtc", "core.norg.qol.todo_items.todo.task_cancelled" },
            { "gtr", "core.norg.qol.todo_items.todo.task_recurring" },
            { "gti", "core.norg.qol.todo_items.todo.task_important" },
            { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },

            -- Keys for managing GTD
            { neorg_leader .. "tc", "core.gtd.base.capture" },
            { neorg_leader .. "tv", "core.gtd.base.views" },
            { neorg_leader .. "te", "core.gtd.base.edit" },

            -- Keys for managing notes
            { neorg_leader .. "nn", "core.norg.dirman.new.note" },

            { "<CR>", "core.norg.esupports.hop.hop-link" },
            { "<M-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },

            { "<M-k>", "core.norg.manoeuvre.item_up" },
            { "<M-j>", "core.norg.manoeuvre.item_down" },

            -- mnemonic: markup toggle
            { neorg_leader .. "mt", "core.norg.concealer.toggle-markup" },
          },
        }, { silent = true, noremap = true })
      end
    )
  end,
})
