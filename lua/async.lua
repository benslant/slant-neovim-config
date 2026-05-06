-- async shim for Neovim 0.11 compatibility
-- refactoring.nvim requires vim.async (Neovim 0.12+); this provides a fallback.
-- Once you upgrade to Neovim 0.12+, this file can be deleted.

-- If Neovim 0.12+ is available, use the built-in
if vim.async then
  return vim.async
end

-- Neovim 0.11 fallback using coroutines
local M = {}

--- Run a function as an async task using coroutines.
---@param fn function
---@return table task with :raise_on_error()
function M.run(fn)
  local co = coroutine.create(fn)
  local ok, err = coroutine.resume(co)
  local task = {}
  task._err = not ok and err or nil
  function task:raise_on_error()
    if self._err then
      error(self._err, 2)
    end
  end
  return task
end

--- Wrap a callback-style async function so it can be used in a coroutine.
---@param argc integer total number of args including the callback
---@param fn function
---@return function
function M.wrap(argc, fn)
  return function(...)
    local args = { ... }
    local co = coroutine.running()
    args[argc] = function(result)
      if co then
        coroutine.resume(co, result)
      end
    end
    fn(unpack(args))
    if co then
      return coroutine.yield()
    end
  end
end

--- Wait for all tasks to complete.
---@param tasks table[]
---@return any[]
function M.await_all(tasks)
  return tasks
end

return M
