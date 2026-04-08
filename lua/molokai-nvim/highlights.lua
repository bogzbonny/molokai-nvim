-- Molokai highlight group definitions

local M = {}

--- Build all highlight groups and set terminal colors.
--- Returns a table of highlight groups (not yet applied).
---@param c table Color palette
---@param config table Resolved configuration
---@return table<string, table> groups
function M.apply(c, config)
  local groups = {}

  local hi = function(group, opts)
    groups[group] = opts
  end

  local link = function(group, target)
    groups[group] = { link = target }
  end

  -- Resolve config
  local italic = config.italic
  local bg = config.bg == "alt" and c.bg_alt or c.bg

  -- Resolve per-group styles (empty table = use theme default)
  local s_comments  = next(config.styles.comments)  and config.styles.comments
    or { italic = italic }
  local s_keywords  = next(config.styles.keywords)  and config.styles.keywords
    or { bold = not italic, italic = italic }
  local s_functions = next(config.styles.functions)  and config.styles.functions
    or {}
  local s_variables = next(config.styles.variables)  and config.styles.variables
    or {}
  local s_types     = next(config.styles.types)      and config.styles.types
    or { italic = italic }

  -----------------------------------------------------------------------------
  -- Core syntax groups
  -----------------------------------------------------------------------------
  hi("Normal",        { fg = c.white, bg = bg })
  hi("Comment",       vim.tbl_extend("force", { fg = c.comment }, s_comments))

  hi("Boolean",       { fg = c.purple, italic = italic })
  hi("Character",     { fg = c.yellow })
  hi("Number",        { fg = c.purple })
  hi("Float",         { fg = c.purple })
  hi("String",        { fg = c.yellow })

  hi("Conditional",   vim.tbl_extend("force", { fg = c.pink }, s_keywords))
  hi("Constant",      { fg = c.purple, bold = not italic, italic = italic })
  hi("Debug",         { fg = c.debug, bold = true })
  hi("Define",        { fg = c.cyan })
  hi("Delimiter",     { fg = c.grey_light })

  hi("Directory",     { fg = c.green, bold = true })
  hi("Error",         { fg = c.yellow, bg = c.bg_diff_d })
  hi("ErrorMsg",      { fg = c.pink, bg = c.bg_sign, bold = true })
  hi("Exception",     vim.tbl_extend("force", { fg = c.green }, s_keywords))

  hi("Function",      vim.tbl_extend("force", { fg = c.green }, s_functions))
  hi("Identifier",    { fg = c.orange })
  hi("Ignore",        { fg = c.grey_mid, bg = bg })
  hi("IncSearch",     { fg = c.tan, bg = c.black })

  hi("Keyword",       vim.tbl_extend("force", { fg = c.pink }, s_keywords))
  hi("Label",         { fg = c.yellow, italic = italic })
  hi("Macro",         { fg = c.tan, italic = italic })
  hi("Operator",      { fg = c.pink })

  hi("PreCondit",     { fg = c.green, bold = true })
  hi("PreProc",       { fg = c.green, italic = italic })
  hi("Question",      { fg = c.cyan })
  hi("Repeat",        vim.tbl_extend("force", { fg = c.pink }, s_keywords))

  hi("Special",       { fg = c.cyan, bg = bg, italic = italic })
  hi("SpecialChar",   { fg = c.pink, bold = true })
  hi("SpecialComment",{ fg = c.comment, bold = true })
  hi("SpecialKey",    { fg = c.grey })

  hi("Statement",     vim.tbl_extend("force", { fg = c.pink }, s_keywords))
  hi("StorageClass",  { fg = c.orange, italic = italic })
  hi("Structure",     { fg = c.cyan })
  hi("Tag",           { fg = c.pink, italic = italic })
  hi("Title",         { fg = c.title_org })
  hi("Todo",          { fg = c.bright_white, bg = bg, bold = true })

  hi("Typedef",       { fg = c.cyan })
  hi("Type",          vim.tbl_extend("force", { fg = c.cyan }, s_types))
  hi("Underlined",    { fg = c.grey_mid, underline = true })

  -----------------------------------------------------------------------------
  -- UI / Editor groups
  -----------------------------------------------------------------------------
  hi("Cursor",        { fg = c.black, bg = c.bright_wht })
  hi("iCursor",       { fg = c.black, bg = c.bright_wht })
  hi("CursorLine",    { bg = c.bg_cursor })
  hi("CursorLineNr",  { fg = c.orange })
  hi("CursorColumn",  { bg = c.bg_cursor })
  hi("ColorColumn",   { bg = c.bg_sign })
  hi("LineNr",        { fg = c.grey, bg = c.bg_sign })
  hi("NonText",       { fg = c.grey })

  hi("MatchParen",    { fg = c.black, bg = c.orange, bold = true })
  hi("ModeMsg",       { fg = c.yellow })
  hi("MoreMsg",       { fg = c.yellow })

  hi("Pmenu",         { fg = c.cyan, bg = c.black })
  hi("PmenuSel",      { fg = c.bright_wht, bg = c.grey_mid })
  hi("PmenuSbar",     { bg = c.bg_dark })
  hi("PmenuThumb",    { fg = c.cyan })
  hi("PmenuKind",     { fg = c.cyan, bg = c.black })
  hi("PmenuExtra",    { fg = c.grey_mid, bg = c.black })

  hi("Search",        { fg = c.black, bg = c.search_bg })
  hi("SignColumn",    { fg = c.green, bg = c.bg_sign })

  hi("StatusLine",    { fg = c.grey_warm, bg = c.white })
  hi("StatusLineNC",  { fg = c.grey_mid, bg = c.bg_dark })

  hi("VertSplit",     { fg = c.grey_mid, bg = c.bg_dark, bold = true })
  hi("WinSeparator",  { fg = c.grey_mid, bg = c.bg_dark })
  hi("Visual",        { bg = c.bg_visual })
  hi("VisualNOS",     { bg = c.bg_visual })
  hi("WarningMsg",    { fg = c.bright_white, bg = c.bg_warning, bold = true })
  hi("WildMenu",      { fg = c.cyan, bg = c.black })

  hi("TabLineFill",   { fg = bg, bg = bg })
  hi("TabLine",       { fg = c.grey_mid, bg = bg })
  hi("TabLineSel",    { fg = c.white, bg = c.bg_sign, bold = true })

  hi("FoldColumn",    { fg = c.grey, bg = c.black })
  hi("Folded",        { fg = c.grey, bg = c.black })

  -----------------------------------------------------------------------------
  -- Diff
  -----------------------------------------------------------------------------
  hi("DiffAdd",       { bg = c.bg_diff_a })
  hi("DiffChange",    { fg = c.grey_diff, bg = c.bg_diff_c })
  hi("DiffDelete",    { fg = c.red_dark, bg = c.bg_diff_d })
  hi("DiffText",      { bg = c.bg_diff_c, bold = true, italic = italic })

  -----------------------------------------------------------------------------
  -- Spell
  -----------------------------------------------------------------------------
  hi("SpellBad",      { sp = c.spell_bad, undercurl = true })
  hi("SpellCap",      { sp = c.spell_cap, undercurl = true })
  hi("SpellLocal",    { sp = c.spell_local, undercurl = true })
  hi("SpellRare",     { sp = c.bright_white, undercurl = true })

  -----------------------------------------------------------------------------
  -- Floating windows & borders
  -----------------------------------------------------------------------------
  hi("NormalFloat",   { fg = c.white, bg = c.black })
  hi("FloatBorder",   { fg = c.grey_mid, bg = c.black })
  hi("FloatTitle",    { fg = c.cyan, bg = c.black, bold = true })

  -----------------------------------------------------------------------------
  -- Diagnostics
  -----------------------------------------------------------------------------
  hi("DiagnosticError",          { fg = c.pink })
  hi("DiagnosticWarn",           { fg = c.orange })
  hi("DiagnosticInfo",           { fg = c.cyan })
  hi("DiagnosticHint",           { fg = c.comment })
  hi("DiagnosticOk",             { fg = c.green })

  hi("DiagnosticUnderlineError", { sp = c.pink, undercurl = true })
  hi("DiagnosticUnderlineWarn",  { sp = c.orange, undercurl = true })
  hi("DiagnosticUnderlineInfo",  { sp = c.cyan, undercurl = true })
  hi("DiagnosticUnderlineHint",  { sp = c.comment, undercurl = true })
  hi("DiagnosticUnderlineOk",    { sp = c.green, undercurl = true })

  hi("DiagnosticVirtualTextError", { fg = c.pink, italic = italic })
  hi("DiagnosticVirtualTextWarn",  { fg = c.orange, italic = italic })
  hi("DiagnosticVirtualTextInfo",  { fg = c.cyan, italic = italic })
  hi("DiagnosticVirtualTextHint",  { fg = c.comment, italic = italic })

  hi("DiagnosticSignError",     { fg = c.pink, bg = c.bg_sign })
  hi("DiagnosticSignWarn",      { fg = c.orange, bg = c.bg_sign })
  hi("DiagnosticSignInfo",      { fg = c.cyan, bg = c.bg_sign })
  hi("DiagnosticSignHint",      { fg = c.comment, bg = c.bg_sign })

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------
  hi("LspReferenceText",        { bg = c.bg_visual })
  hi("LspReferenceRead",        { bg = c.bg_visual })
  hi("LspReferenceWrite",       { bg = c.bg_visual, bold = true })
  hi("LspSignatureActiveParameter", { fg = c.orange, bold = true, underline = true })
  hi("LspInfoBorder",           { fg = c.grey_mid })

  -----------------------------------------------------------------------------
  -- Treesitter highlights
  -----------------------------------------------------------------------------
  -- Identifiers
  hi("@variable",                   vim.tbl_extend("force", { fg = c.white }, s_variables))
  hi("TreesitterVariableBuiltin",   { fg = c.orange, italic = italic })
  hi("TreesitterVariableParameter", { fg = c.orange, italic = italic })
  hi("TreesitterVariableMember",    { fg = c.white })
  link("@variable.builtin",         "VariableBuiltin")
  link("@variable.parameter",       "VariableParameter")
  link("@variable.member",          "VariableMember")
  

  link("@constant",               "Constant")
  link("@constant.builtin",       "Constant")
  link("@constant.macro",         "Macro")

  hi("@module",                  { fg = c.cyan })
  hi("@module.builtin",         { fg = c.cyan, italic = italic })
  link("@label",                   "Label")

  -- Literals
  link("@string",                  "String")
  link("@string.escape",           "SpecialChar")
  link("@string.special",          "Special")
  link("@string.regexp",           "SpecialChar")
  link("@character",               "Character")
  link("@character.special",       "SpecialChar")
  link("@boolean",                 "Boolean")
  link("@number",                  "Number")
  link("@number.float",            "Float")

  -- Types
  link("@type",                    "Type")
  hi("@type.builtin",             { fg = c.cyan, italic = italic })
  link("@type.definition",         "Type")
  link("@attribute",               "Define")
  hi("@attribute.builtin",        { fg = c.cyan, italic = italic })
  link("@property",                "Normal")

  -- Functions
  link("@function",                "Function")
  link("@function.builtin",        "Function")
  hi("@function.call",            { fg = c.green })
  link("@function.macro",          "Macro")
  hi("@function.method",          { fg = c.green })
  hi("@function.method.call",     { fg = c.green })
  link("@constructor",             "Function")

  -- Keywords
  link("@keyword",                 "Keyword")
  hi("@keyword.coroutine",        { fg = c.pink, italic = italic })
  link("@keyword.function",        "Keyword")
  link("@keyword.operator",        "Operator")
  link("@keyword.import",          "Keyword")
  link("@keyword.type",            "Keyword")
  link("@keyword.modifier",        "Keyword")
  link("@keyword.repeat",          "Repeat")
  link("@keyword.return",          "Keyword")
  link("@keyword.debug",           "Debug")
  link("@keyword.exception",       "Exception")

  link("@keyword.conditional",     "Conditional")
  link("@keyword.conditional.ternary", "Operator")
  link("@keyword.directive",       "PreProc")
  link("@keyword.directive.define", "Define")

  -- Operators & punctuation
  link("@operator",                "Operator")
  hi("@punctuation.delimiter",    { fg = c.grey_light })
  hi("@punctuation.bracket",      { fg = c.grey_light })
  hi("@punctuation.special",      { fg = c.pink })

  -- Comments
  link("@comment",                 "Comment")
  hi("@comment.documentation",    { fg = c.comment, italic = italic })
  link("@comment.error",           "DiagnosticError")
  link("@comment.warning",         "DiagnosticWarn")
  link("@comment.todo",            "Todo")
  link("@comment.note",            "DiagnosticInfo")

  -- Markup
  hi("@markup.strong",            { bold = true })
  hi("@markup.italic",            { italic = true })
  hi("@markup.strikethrough",     { strikethrough = true })
  hi("@markup.underline",         { underline = true })
  link("@markup.heading",          "Title")
  hi("@markup.raw",               { fg = c.yellow })
  link("@markup.link",             "Underlined")
  hi("@markup.link.url",          { fg = c.cyan, underline = true })
  hi("@markup.list",              { fg = c.pink })

  -- Tags (HTML/JSX)
  link("@tag",                     "Tag")
  hi("@tag.builtin",              { fg = c.pink })
  hi("@tag.attribute",            { fg = c.green, italic = italic })
  hi("@tag.delimiter",            { fg = c.white })

  -----------------------------------------------------------------------------
  -- Semantic tokens (LSP)
  -----------------------------------------------------------------------------
  link("@lsp.type.class",         "Type")
  link("@lsp.type.decorator",     "Define")
  link("@lsp.type.enum",          "Type")
  link("@lsp.type.enumMember",    "Constant")
  link("@lsp.type.function",      "Function")
  link("@lsp.type.interface",     "Type")
  link("@lsp.type.macro",         "Macro")
  link("@lsp.type.method",        "Function")
  link("@lsp.type.namespace",     "@module")
  link("@lsp.type.parameter",     "@variable.parameter")
  link("@lsp.type.property",      "@property")
  link("@lsp.type.struct",        "Structure")
  link("@lsp.type.type",          "Type")
  link("@lsp.type.typeParameter",  "Type")
  link("@lsp.type.variable",      "@variable")

  -----------------------------------------------------------------------------
  -- Custom overrides (from old init.vim)
  -----------------------------------------------------------------------------
  hi("htmlArg",          { fg = c.green, italic = italic })
  hi("jsArrowFunction",  { fg = c.cyan })
  hi("jsSuper",          { fg = c.purple, italic = italic })

  -----------------------------------------------------------------------------
  -- Git signs (if using gitsigns.nvim or similar)
  -----------------------------------------------------------------------------
  hi("GitSignsAdd",      { fg = c.green, bg = c.bg_sign })
  hi("GitSignsChange",   { fg = c.orange, bg = c.bg_sign })
  hi("GitSignsDelete",   { fg = c.pink, bg = c.bg_sign })

  -----------------------------------------------------------------------------
  -- Telescope (if installed)
  -----------------------------------------------------------------------------
  hi("TelescopeBorder",        { fg = c.grey_mid })
  hi("TelescopePromptBorder",  { fg = c.grey_mid })
  hi("TelescopeResultsBorder", { fg = c.grey_mid })
  hi("TelescopePreviewBorder", { fg = c.grey_mid })
  hi("TelescopeSelectionCaret",{ fg = c.pink })
  hi("TelescopeSelection",     { bg = c.bg_cursor })
  hi("TelescopeMatching",      { fg = c.orange, bold = true })

  -----------------------------------------------------------------------------
  -- blink.cmp (completion)
  -----------------------------------------------------------------------------
  hi("BlinkCmpLabelMatch",  { fg = c.orange, bold = true })
  hi("BlinkCmpMenuBorder",  { fg = c.grey_mid, bg = c.black })
  hi("BlinkCmpDocBorder",   { fg = c.grey_mid, bg = c.black })

  -----------------------------------------------------------------------------
  -- DAP UI (debugger)
  -----------------------------------------------------------------------------
  hi("DapUIWatchesError",   { fg = c.pink })
  hi("DapUIStop",           { fg = c.pink })
  hi("DapUIFloatBorder",    { fg = c.grey_mid })

  -----------------------------------------------------------------------------
  -- Indent guides
  -----------------------------------------------------------------------------
  hi("IndentBlanklineChar",         { fg = c.bg_sign, nocombine = true })
  hi("IndentBlanklineContextChar",  { fg = c.grey, nocombine = true })
  hi("IblIndent",                   { fg = c.bg_sign, nocombine = true })
  hi("IblScope",                    { fg = c.grey, nocombine = true })

  -----------------------------------------------------------------------------
  -- Terminal colors
  -----------------------------------------------------------------------------
  vim.g.terminal_color_0  = c.bg_sign       -- black
  vim.g.terminal_color_1  = c.pink          -- red
  vim.g.terminal_color_2  = c.green         -- green
  vim.g.terminal_color_3  = c.yellow        -- yellow
  vim.g.terminal_color_4  = c.cyan          -- blue
  vim.g.terminal_color_5  = c.purple        -- magenta
  vim.g.terminal_color_6  = c.cyan          -- cyan
  vim.g.terminal_color_7  = c.white         -- white
  vim.g.terminal_color_8  = c.grey_mid      -- bright black
  vim.g.terminal_color_9  = c.pink          -- bright red
  vim.g.terminal_color_10 = c.green         -- bright green
  vim.g.terminal_color_11 = c.yellow        -- bright yellow
  vim.g.terminal_color_12 = c.cyan          -- bright blue
  vim.g.terminal_color_13 = c.purple        -- bright magenta
  vim.g.terminal_color_14 = c.cyan          -- bright cyan
  vim.g.terminal_color_15 = c.bright_white  -- bright white

  return groups
end

return M
