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
--- Provide augroup name to create a new one or use existing.
--- This, however, will not clear the autocommand if you
--- resource the file, or autocommand is called multiple times.
--- Use `group = augroup("name")` for this.
---@param name string | table
---@param opts table
---@return number
function autocmd(name, opts)
  if type(opts.group) == "string" then
    local group_exists, commands =
      pcall(a.nvim_get_autocmds, { group = opts.group })
    local existing_group_id = group_exists and commands[1] and commands[1].group

    opts = vim.tbl_extend(
      "force",
      opts,
      { group = existing_group_id or augroup(opts.group) }
    )
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

---@class vim.SystemOpts
---@field shell? boolean

--- Wrapper around `vim.system` that accepts opts.shell
---@param cmd string | string[]
---@param opts?  vim.SystemOpts
---@param on_exit? fun(res: vim.SystemCompleted)
---@return vim.SystemObj
function system(cmd, opts, on_exit)
  if opts and opts.shell then
    cmd = type(cmd) == "string" and cmd or vim.iter(cmd):join(" ")
    cmd = { "sh", "-c", cmd }
  end

  if type(cmd) == "string" then
    cmd = vim.split(cmd, " ")
  end

  -- TODO
  -- local res = vim.system(cmd, opts, on_exit):wait()
  -- return res.stderr, res.stdout
  return vim.system(cmd, opts, on_exit)
end

-- stylua: ignore
local langmap = { A = "Ф", B = "И", C = "С", D = "В", E = "У", F = "А", G = "П", H = "Р", I = "Ш", J = "О", K = "Л", L = "Д", M = "Ь", N = "Т", O = "Щ", P = "З", Q = "Й", R = "К", S = "Ы", T = "Е", U = "Г", V = "М", W = "Ц", X = "Ч", Y = "Н", Z = "Я", a = "ф", b = "и", c = "с", d = "в", e = "у", f = "а", g = "п", h = "р", i = "ш", j = "о", k = "л", l = "д", m = "ь", n = "т", o = "щ", p = "з", q = "й", r = "к", s = "ы", t = "е", u = "г", v = "м", w = "ц", x = "ч", y = "н", z = "я", }

--- Create keymapping
---@param mode string | table
---@param lhs string
---@param rhs string | function
---@param optsOrDesc? table | string descriptions string or options table
function map(mode, lhs, rhs, optsOrDesc)
  local options = { noremap = true, silent = true }
  if type(optsOrDesc) == "string" then
    options.desc = optsOrDesc
  elseif type(optsOrDesc) == "table" then
    options = vim.tbl_extend("force", options, optsOrDesc)
  end
  vim.keymap.set(mode, lhs, rhs, options)

  local char = langmap[string.match(lhs, "<C%-(%a)>")]
  if char then
    vim.keymap.set(mode, "<C-" .. char .. ">", rhs, options)
  end
end

function flatten_map(table)
  local result = {}

  local function traverse(tbl, path)
    for key, value in pairs(tbl) do
      local newPath = path .. key
      if type(value) == "table" then
        if value[1] then
          result[newPath] = value
        else
          traverse(value, newPath)
        end
      else
        if key == "name" then
          req("which-key").register({ [path] = value })
        else
          result[newPath] = value
        end
      end
    end
  end

  traverse(table, "")
  return result
end

--- Create keymappings from a table
---@param keys_tbl_or_mode table | string
---@param opts_or_keys_tbl? table
---@param global_opts? table
function mapt(keys_tbl_or_mode, opts_or_keys_tbl, global_opts)
  local keys_tbl
  local global_mode = "n"
  if type(keys_tbl_or_mode) == "string" then
    global_mode = keys_tbl_or_mode
    keys_tbl = opts_or_keys_tbl
    global_opts = global_opts or {}
  elseif keys_tbl_or_mode[1] then
    global_mode = keys_tbl_or_mode[1]
    keys_tbl = opts_or_keys_tbl
    global_opts = global_opts or {}
  else
    keys_tbl = keys_tbl_or_mode
    global_opts =
      vim.tbl_extend("force", global_opts or {}, opts_or_keys_tbl or {})
  end

  local merged_tbl = flatten_map(keys_tbl)

  local prefix = global_opts.prefix or ""

  for lhs, value in pairs(merged_tbl) do
    local mode = value.mode or global_mode
    local opts = vim
      .iter(vim.tbl_extend("force", global_opts, value))
      :filter( -- filter out keys that cannot be passed to vim.keymap.set
        function(key)
          return type(key) ~= "number" and key ~= "prefix" and key ~= "mode"
        end
      )
      :fold({}, function(acc, k, v)
        acc[k] = v
        return acc
      end)
    if type(value[2] == "string") then
      opts.desc = opts.desc or value[2]
    end

    map(mode, prefix .. lhs, value[1], opts)
  end
end

--- Create leader keymappings from a table
---@param keys_tbl_or_mode table | string
---@param opts_or_keys_tbl? table
---@param opts? table
function mapl(keys_tbl_or_mode, opts_or_keys_tbl, opts)
  opts = opts or {}
  opts.prefix = "<leader>"
  mapt(keys_tbl_or_mode, opts_or_keys_tbl, opts)
end

function Plugin(spec)
  if spec[1] then
    spec.source = spec[1]
  end
  req("mini.deps").add(spec)
end

--- Dummy function to skip loading plugin instead of commenting out
function xPlugin(_spec) end

curry = req("utils.curry")

a = vim.api
fn = vim.fn
cmd = vim.cmd
cmd.bind = function(cmd)
  return function()
    vim.cmd(cmd)
  end
end
