Plugin("rcarriga/nvim-notify")

local match_groups = { "%(mini%.deps%) %(%d+/%d+%) Downloaded update for" }

local cache = {}
vim.notify = function(msg, log_level, user_opts)
  local opts = user_opts

  for _, val in ipairs(match_groups) do
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
    else
      req("notify").notify(msg, log_level, opts)
    end
  end
end
