Plugin("rcarriga/nvim-notify")
Plugin("vigoux/notifier.nvim")
Plugin("echasnovski/mini.notify")

local group_notifs = { "%(mini%.deps%) %(%d+/%d+%) Downloaded update for" }
local titles = { "%((mini%.deps)%)" }
local removes = { "%[NvimTree%]", "%(mini%.deps%) ", vim.uv.cwd() .. "/" }
local replaces = { { os.getenv("HOME"), "~" } }
local notifier = { "%[NvimTree%]" }

local replace_msg = function(msg)
  local res = msg
  for _, to_remove in ipairs(removes) do
    res = res:gsub(to_remove, "")
  end
  for _, to_replace in ipairs(replaces) do
    res = res:gsub(to_replace[1], to_replace[2])
  end
  return res
end

local get_title = function(msg)
  for _, title in ipairs(titles) do
    local match = msg:match(title)
    return match
  end
end

local get_notify_fn = function(msg)
  for _, match in ipairs(notifier) do
    if msg:match(match) then
      -- return req("notifier").notify

      return req("mini.notify").make_notify()
    else
      return req("notify").notify
    end
  end

  -- local extra_opts = gg
end

local cache = {}
vim.notify = function(msg, log_level, user_opts)
  local opts = user_opts or {}

  for _, val in ipairs(group_notifs) do
    if msg:match(val) then
      opts = vim.tbl_extend("keep", user_opts or {}, {
        replace = cache[val],
        on_open = function(_, record)
          cache[val] = record
        end,
        on_close = function()
          cache[val] = nil
        end,
      })

      cache[val] = req("notify").notify(msg, log_level, opts)
      return
    end
  end

  local notify = get_notify_fn(msg)
  opts.title = opts.title or get_title(msg)
  msg = replace_msg(msg)
  notify(msg, log_level, opts)
end
