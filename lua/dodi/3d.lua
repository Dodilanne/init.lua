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

  -- Ensure the origin is really at the center of the window
  if dims.x % 2 == 0 then
    dims.x = dims.x - 1
  end
  if dims.y % 2 == 0 then
    dims.y = dims.y - 1
  end

  if dims.x < 0 or dims.y < 0 then
    print("window too small")
    return
  end

  -- Fill the window with spaces
  local row_text = string.rep(" ", dims.x)
  local empty_lines = {}
  for _ = 1, dims.y do
    table.insert(empty_lines, row_text)
  end
  vim.api.nvim_buf_set_lines(buf, 0, dims.y, false, empty_lines)

  local points = {
    { x = 0, y = 0 },
  }
  for _, point in ipairs(points) do
    local projected = {
      x = point.x + math.floor(dims.x / 2),
      y = point.y + math.floor(dims.y / 2),
    }
    vim.api.nvim_buf_set_text(buf, projected.y, projected.x, projected.y, projected.x, { "*" })
  end

  vim.api.nvim_open_win(buf, true, {
    relative = "win",
    row = padding.y / 2,
    col = padding.x / 2,
    width = dims.x,
    height = dims.y,
    border = "rounded",
    style = "minimal",
  })

  vim.keymap.set("n", "<leader>t", toggle, { buffer = true })

  state = {
    timer = nil,
    buf = buf,
  }
end
