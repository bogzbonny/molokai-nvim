-- Lualine theme for molokai-nvim
-- Auto-discovered when lualine theme = "auto" and colorscheme = "molokai-nvim"

local c = require("molokai-nvim").colors()

return {
  normal = {
    a = { fg = c.black, bg = c.green, bold = true },
    b = { fg = c.white, bg = c.bg_sign },
    c = { fg = c.grey_mid, bg = c.bg_statusline },
  },
  insert = {
    a = { fg = c.black, bg = c.cyan, bold = true },
  },
  visual = {
    a = { fg = c.black, bg = c.purple, bold = true },
  },
  replace = {
    a = { fg = c.black, bg = c.pink, bold = true },
  },
  command = {
    a = { fg = c.black, bg = c.orange, bold = true },
  },
  terminal = {
    a = { fg = c.black, bg = c.green, bold = true },
  },
  inactive = {
    a = { fg = c.grey_mid, bg = c.bg_dark },
    b = { fg = c.grey_mid, bg = c.bg_dark },
    c = { fg = c.grey_mid, bg = c.bg_dark },
  },
}
