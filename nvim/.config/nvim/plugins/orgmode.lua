-- Load custom tree-sitter grammar for org filetype

require("orgmode").setup({
  org_agenda_files = { "~/docs/nextcloud/Vault/org/*" },
  org_default_notes_file = "~/docs/nextcloud/Vault/org/refile.org",
})

-- require("headlines").setup()

require("org-bullets").setup({
  symbols = { "◉", "○", "✸", "✿" },
})
