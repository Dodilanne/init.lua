---@type { timer: integer?, buf: integer }?
local state = nil

local stop = function()
  if state and state.timer then
    vim.fn.timer_stop(state.timer)
    state.timer = nil
  end
end

local start = function()
  stop()
  state.timer = vim.fn.timer_start(1000, function()
    if state == nil then
      return
    end
    local contents = vim.api.nvim_buf_get_lines(state.buf, 0, 1, false)
    local count = tonumber(vim.fn.trim(contents[1]))
    if count == nil then
      print("read invalid count from buffer")
      return
    end
    vim.api.nvim_buf_set_lines(state.buf, 0, 1, false, { tostring(count + 1) })
  end, { ["repeat"] = -1 })
end

local toggle = function()
  if state and state.timer then
    stop()
  else
    start()
  end
end

THREED = function()
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    callback = function()
      stop()
      state = nil
    end,
  })

  local padding = { x = 60, y = 20 }
  local dims = {
    x = vim.api.nvim_win_get_width(0) - padding.x,
    y = vim.api.nvim_win_get_height(0) - padding.y,
  }

  if dims.x < 0 or dims.y < 0 then
    print("window too small")
    return
  end

  vim.api.nvim_buf_set_lines(buf, 0, 1, false, { "0" })
  vim.api.nvim_open_win(buf, true, {
    relative = "win",
    row = padding.y / 2,
    col = padding.x / 2,
    width = dims.x,
    height = dims.y,
    border = "rounded",
  })

  vim.keymap.set("n", "<leader>t", toggle, { buffer = true })

  state = {
    timer = nil,
    buf = buf,
  }
end
