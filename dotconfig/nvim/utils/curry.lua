--- Curry methods and namespaces in a given module
---@examples
--- curry("mymodule").method(opts)()
--- curry("mymodule").namespace.method(opts)()
local function curry(module_name)
  local module = {}
  setmetatable(module, {
    __index = function(_, method)
      local res = {}
      setmetatable(res, {
        __call = function(_, ...)
          local args = { ... }
          return function()
            return req(module_name)[method](unpack(args))
          end
        end,
        __index = function(_, method2)
          local inner = {}
          setmetatable(res, {
            __call = function(_, ...)
              local args2 = { ... }
              return function()
                return req(module_name)[method][method2](unpack(args2))
              end
            end,
          })
          return inner
        end,
      })
      return res
    end,
  })
  return module
end

return curry
