-- Red Fox Neovim Color Scheme
-- Save this as ~/.config/nvim/colors/redfox.lua
-- Then use with :colorscheme redfox

local colors = {
  bg = "#1a1d2e",
  bg_light = "#232738",
  bg_lighter = "#2d3142",
  fg = "#f5e6d3",
  fg_dim = "#d0c4b3",
  
  black = "#2d3142",
  red = "#d94f3d",
  green = "#e8b4a0",
  yellow = "#ffb085",
  blue = "#4a5568",
  magenta = "#b8405e",
  cyan = "#8fa8a0",
  white = "#f5e6d3",
  
  bright_black = "#4a4e69",
  bright_red = "#ff6b35",
  bright_green = "#f4c7ab",
  bright_yellow = "#ffd6ba",
  bright_blue = "#6b7a8f",
  bright_magenta = "#d16666",
  bright_cyan = "#b8c5bc",
  bright_white = "#ffffff",
  
  orange = "#ff6b35",
  rose = "#b8405e",
}

-- Clear existing highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.background = 'dark'
vim.g.colors_name = 'redfox'

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("NormalFloat", { fg = colors.fg, bg = colors.bg_light })
hl("NormalNC", { fg = colors.fg, bg = colors.bg })
hl("LineNr", { fg = colors.bright_black })
hl("CursorLine", { bg = colors.bg_light })
hl("CursorLineNr", { fg = colors.orange, bold = true })
hl("Visual", { bg = colors.bg_lighter })
hl("VisualNOS", { bg = colors.bg_lighter })
hl("Search", { fg = colors.bg, bg = colors.yellow })
hl("IncSearch", { fg = colors.bg, bg = colors.orange })
hl("CurSearch", { fg = colors.bg, bg = colors.orange })
hl("ColorColumn", { bg = colors.bg_light })
hl("Conceal", { fg = colors.blue })
hl("Cursor", { fg = colors.bg, bg = colors.orange })
hl("lCursor", { fg = colors.bg, bg = colors.orange })
hl("CursorIM", { fg = colors.bg, bg = colors.orange })
hl("Directory", { fg = colors.bright_blue })
hl("DiffAdd", { fg = colors.green, bg = colors.bg_light })
hl("DiffChange", { fg = colors.yellow, bg = colors.bg_light })
hl("DiffDelete", { fg = colors.red, bg = colors.bg_light })
hl("DiffText", { fg = colors.orange, bg = colors.bg_light, bold = true })
hl("EndOfBuffer", { fg = colors.bg })
hl("ErrorMsg", { fg = colors.bright_red, bold = true })
hl("VertSplit", { fg = colors.bg_lighter })
hl("WinSeparator", { fg = colors.bg_lighter })
hl("Folded", { fg = colors.cyan, bg = colors.bg_light })
hl("FoldColumn", { fg = colors.bright_black })
hl("SignColumn", { fg = colors.fg, bg = colors.bg })
hl("MatchParen", { fg = colors.orange, bold = true })
hl("ModeMsg", { fg = colors.orange, bold = true })
hl("MoreMsg", { fg = colors.green })
hl("NonText", { fg = colors.bright_black })
hl("Pmenu", { fg = colors.fg, bg = colors.bg_light })
hl("PmenuSel", { fg = colors.bg, bg = colors.orange })
hl("PmenuSbar", { bg = colors.bg_lighter })
hl("PmenuThumb", { bg = colors.orange })
hl("Question", { fg = colors.green })
hl("QuickFixLine", { fg = colors.bg, bg = colors.yellow })
hl("SpecialKey", { fg = colors.bright_black })
hl("SpellBad", { sp = colors.red, undercurl = true })
hl("SpellCap", { sp = colors.yellow, undercurl = true })
hl("SpellLocal", { sp = colors.cyan, undercurl = true })
hl("SpellRare", { sp = colors.magenta, undercurl = true })
hl("StatusLine", { fg = colors.fg, bg = colors.bg_light })
hl("StatusLineNC", { fg = colors.bright_black, bg = colors.bg_light })
hl("TabLine", { fg = colors.fg_dim, bg = colors.bg_light })
hl("TabLineFill", { bg = colors.bg_light })
hl("TabLineSel", { fg = colors.orange, bg = colors.bg, bold = true })
hl("Title", { fg = colors.orange, bold = true })
hl("WarningMsg", { fg = colors.yellow })
hl("Whitespace", { fg = colors.bright_black })
hl("WildMenu", { fg = colors.bg, bg = colors.orange })

-- Syntax highlights
hl("Comment", { fg = colors.bright_black, italic = true })
hl("Constant", { fg = colors.bright_yellow })
hl("String", { fg = colors.green })
hl("Character", { fg = colors.green })
hl("Number", { fg = colors.bright_yellow })
hl("Boolean", { fg = colors.bright_yellow })
hl("Float", { fg = colors.bright_yellow })
hl("Identifier", { fg = colors.cyan })
hl("Function", { fg = colors.bright_blue })
hl("Statement", { fg = colors.orange })
hl("Conditional", { fg = colors.orange })
hl("Repeat", { fg = colors.orange })
hl("Label", { fg = colors.orange })
hl("Operator", { fg = colors.fg })
hl("Keyword", { fg = colors.orange })
hl("Exception", { fg = colors.red })
hl("PreProc", { fg = colors.magenta })
hl("Include", { fg = colors.magenta })
hl("Define", { fg = colors.magenta })
hl("Macro", { fg = colors.magenta })
hl("PreCondit", { fg = colors.magenta })
hl("Type", { fg = colors.bright_cyan })
hl("StorageClass", { fg = colors.orange })
hl("Structure", { fg = colors.bright_cyan })
hl("Typedef", { fg = colors.bright_cyan })
hl("Special", { fg = colors.rose })
hl("SpecialChar", { fg = colors.rose })
hl("Tag", { fg = colors.bright_red })
hl("Delimiter", { fg = colors.fg })
hl("SpecialComment", { fg = colors.cyan, italic = true })
hl("Debug", { fg = colors.red })
hl("Underlined", { fg = colors.bright_blue, underline = true })
hl("Ignore", { fg = colors.bright_black })
hl("Error", { fg = colors.bright_red, bold = true })
hl("Todo", { fg = colors.bg, bg = colors.yellow, bold = true })

-- Treesitter highlights
hl("@variable", { fg = colors.fg })
hl("@variable.builtin", { fg = colors.magenta })
hl("@variable.parameter", { fg = colors.cyan })
hl("@variable.member", { fg = colors.cyan })
hl("@constant", { fg = colors.bright_yellow })
hl("@constant.builtin", { fg = colors.bright_yellow })
hl("@module", { fg = colors.bright_cyan })
hl("@string", { fg = colors.green })
hl("@string.escape", { fg = colors.rose })
hl("@character", { fg = colors.green })
hl("@number", { fg = colors.bright_yellow })
hl("@boolean", { fg = colors.bright_yellow })
hl("@function", { fg = colors.bright_blue })
hl("@function.builtin", { fg = colors.bright_blue })
hl("@function.macro", { fg = colors.magenta })
hl("@keyword", { fg = colors.orange })
hl("@keyword.function", { fg = colors.orange })
hl("@keyword.operator", { fg = colors.orange })
hl("@keyword.return", { fg = colors.orange })
hl("@operator", { fg = colors.fg })
hl("@type", { fg = colors.bright_cyan })
hl("@type.builtin", { fg = colors.bright_cyan })
hl("@constructor", { fg = colors.bright_blue })
hl("@tag", { fg = colors.bright_red })
hl("@tag.attribute", { fg = colors.cyan })
hl("@tag.delimiter", { fg = colors.bright_black })
hl("@punctuation.delimiter", { fg = colors.fg })
hl("@punctuation.bracket", { fg = colors.fg })
hl("@comment", { link = "Comment" })

-- LSP highlights
hl("DiagnosticError", { fg = colors.red })
hl("DiagnosticWarn", { fg = colors.yellow })
hl("DiagnosticInfo", { fg = colors.bright_blue })
hl("DiagnosticHint", { fg = colors.cyan })
hl("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = colors.bright_blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = colors.cyan, undercurl = true })

-- Git highlights
hl("GitSignsAdd", { fg = colors.green })
hl("GitSignsChange", { fg = colors.yellow })
hl("GitSignsDelete", { fg = colors.red })

-- Telescope highlights
hl("TelescopeNormal", { fg = colors.fg, bg = colors.bg_light })
hl("TelescopeBorder", { fg = colors.bg_lighter, bg = colors.bg_light })
hl("TelescopePromptNormal", { fg = colors.fg, bg = colors.bg_lighter })
hl("TelescopePromptBorder", { fg = colors.bg_lighter, bg = colors.bg_lighter })
hl("TelescopePromptTitle", { fg = colors.orange, bold = true })
hl("TelescopePreviewTitle", { fg = colors.green, bold = true })
hl("TelescopeResultsTitle", { fg = colors.cyan, bold = true })
hl("TelescopeSelection", { fg = colors.orange, bg = colors.bg_lighter, bold = true })
hl("TelescopeMatching", { fg = colors.bright_red, bold = true })
