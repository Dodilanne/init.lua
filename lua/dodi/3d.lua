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

  local function project(point)
    return {
      math.floor(dims.x / 2) + point[1],
      math.floor(dims.y / 2) - point[2],
    }
  end

  local function render_point(point)
    vim.api.nvim_buf_set_text(buf, point[2], point[1], point[2], point[1] + 1, { "*" })
  end

  local function render_line(s, e)
    local denom = (e[1] - s[1])
    if denom == 0 then
      local p = { s[2], e[2] }
      table.sort(p)
      for y = p[1], p[2] do
        render_point({ s[1], y })
      end
    else
      local m = (e[2] - s[2]) / denom
      local b = s[2] - (m * s[1])
      local p = { s[1], e[1] }
      table.sort(p)
      for x = p[1], p[2] do
        local y = math.ceil(m * x + b)
        render_point({ x, y })
      end
    end
  end

  -- Fill the window with spaces
  local row_text = string.rep(" ", dims.x)
  local empty_lines = {}
  for _ = 1, dims.y do
    table.insert(empty_lines, row_text)
  end
  vim.api.nvim_buf_set_lines(buf, 0, dims.y, false, empty_lines)

  local lines = {
    { 0, 0, 0, 5 },
    { 0, 5, 10, 5 },
    { 10, 5, 10, 0 },
    { 10, 0, 0, 0 },
  }

  for _, line in ipairs(lines) do
    render_line(project({ line[1], line[2] }), project({ line[3], line[4] }))
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
