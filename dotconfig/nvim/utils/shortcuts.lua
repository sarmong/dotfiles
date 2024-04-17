---@diagnostic disable: lowercase-global

--- Create autogroup
---@param name string
---@param opts? table
---@return number
function augroup(name, opts)
  opts = opts or {}
  return vim.api.nvim_create_augroup(name, opts)
end

--- Create autocommand
---@param name string | table
---@param opts table
---@return number
function autocmd(name, opts)
  if type(opts.group) == "string" then
    opts = vim.tbl_extend("force", opts, { group = augroup(opts.group) })
  end
  return vim.api.nvim_create_autocmd(name, opts)
end

--- Create user command
---@param name string
---@param fn string | function
---@param opts? table
function command(name, fn, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, fn, opts)
end

-- stylua: ignore
local langmap = { A = "Ф", B = "И", C = "С", D = "В", E = "У", F = "А", G = "П", H = "Р", I = "Ш", J = "О", K = "Л", L = "Д", M = "Ь", N = "Т", O = "Щ", P = "З", Q = "Й", R = "К", S = "Ы", T = "Е", U = "Г", V = "М", W = "Ц", X = "Ч", Y = "Н", Z = "Я", a = "ф", b = "и", c = "с", d = "в", e = "у", f = "а", g = "п", h = "р", i = "ш", j = "о", k = "л", l = "д", m = "ь", n = "т", o = "щ", p = "з", q = "й", r = "к", s = "ы", t = "е", u = "г", v = "м", w = "ц", x = "ч", y = "н", z = "я", }

--- Create keymapping
---@param mode string | table
---@param lhs string
---@param rhs string | function
---@param opts? table
function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)

  local char = langmap[string.match(lhs, "<C%-(%a)>")]
  if char then
    vim.keymap.set(mode, "<C-" .. char .. ">", rhs, options)
  end
end

a = vim.api
fn = vim.fn
cmd = vim.cmd
cmd.bind = function(cmd)
  return function()
    vim.cmd(cmd)
  end
end
