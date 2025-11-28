local M = {}

---@param opts? lazydev.Config
function M.setup(opts)
  if vim.bo.filetype == "lua" then
    require("lazydev.config").setup(opts)
  else
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazydev-startup", { clear = true }),
      pattern = "lua",
      once = true,
      callback = function()
        require("lazydev.config").setup(opts)
      end,
    })
  end
end

--- Checks if the current buffer is in a workspace:
--- * part of the workspace root
--- * part of the workspace libraries
--- Returns the workspace root if found
---@param buf? integer
function M.find_workspace(buf)
  local fname = vim.api.nvim_buf_get_name(buf or 0)
  local Workspace = require("lazydev.workspace")
  local ws = Workspace.find({ path = fname })
  return ws and ws:root_dir() or nil
end

return M
