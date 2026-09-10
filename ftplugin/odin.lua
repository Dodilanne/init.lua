vim.opt_local.errorformat = table.concat({
  -- main error line: /path/file.odin(5:8) Error: message
  [[%f(%l:%c) %m]],
  -- secondary "at" location, e.g. the original declaration
  [[%*[ \t]at %f(%l:%c)%.%#]],
  -- swallow everything else (source snippet, caret, banner lines)
  [[%-G%.%#]],
}, ",")
