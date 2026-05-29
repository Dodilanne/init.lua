---@type { timer: integer?, buf: integer, dt: integer, dims: {x: integer, y: integer}  }?
local state = nil

local round = function(v)
  return v >= 0 and math.floor(v + 0.5) or math.ceil(v - 0.5)
end

local function project(point)
  return {
    point[1] / point[3],
    point[2] / point[3],
  }
end

local function screen(point)
  assert(state)
  return {
    round((point[1] + 1) / 2 * state.dims.x),
    round((point[2] + 1) / 2 * state.dims.y),
  }
end

local function rotate(point, theta)
  local x = point[1]
  local y = point[2]
  local z = point[3]
  return {
    x * math.cos(theta) - z * math.sin(theta),
    y,
    x * math.sin(theta) + z * math.cos(theta),
  }
end

local function translate(point, dz)
  local x = point[1]
  local y = point[2]
  local z = point[3]
  return {
    x,
    y,
    z + dz,
  }
end

local function render_point(point)
  assert(state)

  if point[1] > 0 and point[2] > 0 and point[1] < state.dims.x and point[2] < state.dims.y then
    vim.api.nvim_buf_set_text(state.buf, point[2], point[1], point[2], point[1] + 1, { "*" })
  end
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

local function clear()
  assert(state)
  -- Fill the window with spaces
  local row_text = string.rep(" ", state.dims.x)
  local empty_lines = {}
  for _ = 1, state.dims.y do
    table.insert(empty_lines, row_text)
  end
  vim.api.nvim_buf_set_lines(state.buf, 0, state.dims.y, false, empty_lines)
end

local function frame()
  local vs = {
    -- front face
    { -0.5, -0.5, 0.5 },
    { -0.5, 0.5, 0.5 },
    { 0.5, 0.5, 0.5 },
    { 0.5, -0.5, 0.5 },
    -- back face
    { -0.5, -0.5, -0.5 },
    { -0.5, 0.5, -0.5 },
    { 0.5, 0.5, -0.5 },
    { 0.5, -0.5, -0.5 },
  }

  local fs = {
    { 1, 2, 3, 4 },
    { 5, 6, 7, 8 },
    { 1, 5 },
    { 2, 6 },
    { 3, 7 },
    { 4, 8 },
  }

  local transform = function(point)
    assert(state)
    local angle = (2 * math.pi * state.dt) % 2 * math.pi
    return screen(project(translate(rotate(point, angle), 1.5)))
  end

  for _, f in ipairs(fs) do
    for i, vi in ipairs(f) do
      local s = transform(vs[vi])
      local ei = i + 1 > #f and 1 or i + 1
      local e = transform(vs[f[ei]])
      render_line(s, e)
    end
  end
end

local function update()
  clear()
  frame()
end

local stop = function()
  if state and state.timer then
    vim.fn.timer_stop(state.timer)
    state.timer = nil
  end
end

local start = function()
  stop()
  state.timer = vim.fn.timer_start(math.floor(1000 / 60), function()
    assert(state)
    state.dt = state.dt + math.floor(10000 / 60)
    update()
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

  vim.keymap.set("n", "<leader>T", toggle, { buffer = buf, desc = "Toggle animation" })
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf, desc = "Quit demo" })

  state = {
    timer = nil,
    buf = buf,
    dims = dims,
    dt = 0,
  }

  vim.api.nvim_open_win(buf, true, {
    relative = "win",
    row = padding.y / 2,
    col = padding.x / 2,
    width = dims.x,
    height = dims.y,
    border = "rounded",
    style = "minimal",
  })

  start()
end

vim.keymap.set("n", "<leader>T", THREED, { desc = "Rotating cube demo" })
