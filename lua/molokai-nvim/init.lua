-- Molokai colorscheme for Neovim (Lua port)
--
-- Based on molokai.vim by Tomas Restrepo <tomas@winterdom.com>
-- https://github.com/tomasr/molokai
--
-- Originally based on the Monokai theme for TextMate
-- by Wimer Hazenberg and its darker variant by Hamish Stuart Macpherson.
--
-- Usage:
--   require("molokai-nvim").setup({
--     italic = true,        -- enable italic styling (default: true)
--     bg = "dark",          -- "dark" (#1B1D1E) or "alt" (#272822, original Monokai)
--     styles = {
--       comments  = { italic = true },
--       keywords  = { bold = true },
--       functions = {},
--       variables = {},
--       types     = { italic = true },
--     },
--     on_colors = function(colors)
--       colors.bg = "#000000"
--     end,
--     on_highlights = function(hl, colors)
--       hl.Normal = { fg = colors.white, bg = "#000000" }
--     end,
--   })
--   vim.cmd.colorscheme("molokai-nvim")
--
-- Access resolved colors for plugin integration (e.g. lualine):
--   local colors = require("molokai-nvim").colors()
--
-- Access raw palette (without config resolution):
--   local palette = require("molokai-nvim").palette()

local M = {}

---@class MolokaiStyles
---@field comments?  table Style overrides for comments (e.g. { italic = true })
---@field keywords?  table Style overrides for keywords, conditionals, repeats, etc.
---@field functions? table Style overrides for function definitions
---@field variables? table Style overrides for variables
---@field types?     table Style overrides for types and typedefs

---@class MolokaiConfig
---@field italic boolean Enable italic styling (default: true)
---@field bg "dark"|"alt" Background variant (default: "dark")
---@field styles MolokaiStyles Per-group style overrides (empty = use theme default)
---@field on_colors fun(colors: table) Hook to modify palette before highlights are computed
---@field on_highlights fun(hl: table, colors: table) Hook to override highlight groups

---@type MolokaiConfig
local defaults = {
  italic = true,
  bg = "dark",
  styles = {
    comments  = {},
    keywords  = {},
    functions = {},
    variables = {},
    types     = {},
  },
  on_colors = function(_) end,
  on_highlights = function(_, _) end,
}

---@type MolokaiConfig
M.config = vim.deepcopy(defaults)

--- Configure molokai. Call before `vim.cmd.colorscheme("molokai-nvim")`.
---@param opts? MolokaiConfig
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

--- Load the colorscheme. Called automatically by `colors/molokai-nvim.lua`.
function M.load()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "molokai-nvim"
  vim.o.background = "dark"
  vim.o.termguicolors = true

  -- Clear cached modules so reloading always starts from fresh data
  package.loaded["molokai-nvim.palette"] = nil
  package.loaded["molokai-nvim.highlights"] = nil

  local palette = require("molokai-nvim.palette")

  -- Let user modify palette before highlights are computed
  M.config.on_colors(palette)

  local highlights = require("molokai-nvim.highlights")
  local groups = highlights.apply(palette, M.config)

  -- Let user override specific highlight groups
  M.config.on_highlights(groups, palette)

  -- Apply all highlight groups
  for group, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

--- Return the raw color palette table.
---@return table
function M.palette()
  return require("molokai-nvim.palette")
end

--- Return resolved colors (palette + config applied).
--- Useful for integrating with statusline plugins, lualine, etc.
---@return table
function M.colors()
  local c = require("molokai-nvim.palette")
  return vim.tbl_extend("force", c, {
    bg = M.config.bg == "alt" and c.bg_alt or c.bg,
  })
end

return M
