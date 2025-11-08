-- Rosé Pine Dawn Neovim Color Scheme
-- Save this as ~/.config/nvim/colors/rose-pine-dawn.lua
-- Then use with :colorscheme rose-pine-dawn

local colors = {
  base = "#faf4ed",
  surface = "#fffaf3",
  overlay = "#f2e9e1",
  muted = "#9893a5",
  subtle = "#797593",
  text = "#575279",
  love = "#b4637a",
  gold = "#ea9d34",
  rose = "#d7827e",
  pine = "#286983",
  foam = "#56949f",
  iris = "#907aa9",
  highlight_low = "#f4ede8",
  highlight_med = "#dfdad9",
  highlight_high = "#cecacd",
}

-- Clear existing highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.background = 'light'
vim.g.colors_name = 'rose-pine-dawn'

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hl("Normal", { fg = colors.text, bg = colors.base })
hl("NormalFloat", { fg = colors.text, bg = colors.surface })
hl("NormalNC", { fg = colors.text, bg = colors.base })
hl("LineNr", { fg = colors.muted })
hl("CursorLine", { bg = colors.highlight_low })
hl("CursorLineNr", { fg = colors.gold, bold = true })
hl("Visual", { bg = colors.highlight_med })
hl("VisualNOS", { bg = colors.highlight_med })
hl("Search", { fg = colors.base, bg = colors.gold })
hl("IncSearch", { fg = colors.base, bg = colors.rose })
hl("CurSearch", { fg = colors.base, bg = colors.rose })
hl("ColorColumn", { bg = colors.surface })
hl("Conceal", { fg = colors.muted })
hl("Cursor", { fg = colors.base, bg = colors.text })
hl("lCursor", { fg = colors.base, bg = colors.text })
hl("CursorIM", { fg = colors.base, bg = colors.text })
hl("Directory", { fg = colors.foam })
hl("DiffAdd", { fg = colors.pine, bg = colors.surface })
hl("DiffChange", { fg = colors.gold, bg = colors.surface })
hl("DiffDelete", { fg = colors.love, bg = colors.surface })
hl("DiffText", { fg = colors.pine, bg = colors.surface, bold = true })
hl("EndOfBuffer", { fg = colors.base })
hl("ErrorMsg", { fg = colors.love, bold = true })
hl("VertSplit", { fg = colors.overlay })
hl("WinSeparator", { fg = colors.overlay })
hl("Folded", { fg = colors.muted, bg = colors.surface })
hl("FoldColumn", { fg = colors.muted })
hl("SignColumn", { fg = colors.text, bg = colors.base })
hl("MatchParen", { fg = colors.rose, bold = true, underline = true })
hl("ModeMsg", { fg = colors.gold, bold = true })
hl("MoreMsg", { fg = colors.iris })
hl("NonText", { fg = colors.muted })
hl("Pmenu", { fg = colors.text, bg = colors.surface })
hl("PmenuSel", { fg = colors.base, bg = colors.iris })
hl("PmenuSbar", { bg = colors.overlay })
hl("PmenuThumb", { bg = colors.muted })
hl("Question", { fg = colors.gold })
hl("QuickFixLine", { fg = colors.base, bg = colors.gold })
hl("SpecialKey", { fg = colors.muted })
hl("SpellBad", { sp = colors.love, undercurl = true })
hl("SpellCap", { sp = colors.gold, undercurl = true })
hl("SpellLocal", { sp = colors.foam, undercurl = true })
hl("SpellRare", { sp = colors.iris, undercurl = true })
hl("StatusLine", { fg = colors.text, bg = colors.surface })
hl("StatusLineNC", { fg = colors.muted, bg = colors.surface })
hl("TabLine", { fg = colors.subtle, bg = colors.surface })
hl("TabLineFill", { bg = colors.surface })
hl("TabLineSel", { fg = colors.gold, bg = colors.base, bold = true })
hl("Title", { fg = colors.gold, bold = true })
hl("WarningMsg", { fg = colors.gold })
hl("Whitespace", { fg = colors.muted })
hl("WildMenu", { fg = colors.base, bg = colors.iris })

-- Syntax highlights
hl("Comment", { fg = colors.muted, italic = true })
hl("Constant", { fg = colors.gold })
hl("String", { fg = colors.gold })
hl("Character", { fg = colors.gold })
hl("Number", { fg = colors.gold })
hl("Boolean", { fg = colors.rose })
hl("Float", { fg = colors.gold })
hl("Identifier", { fg = colors.rose })
hl("Function", { fg = colors.iris })
hl("Statement", { fg = colors.pine })
hl("Conditional", { fg = colors.pine })
hl("Repeat", { fg = colors.pine })
hl("Label", { fg = colors.foam })
hl("Operator", { fg = colors.subtle })
hl("Keyword", { fg = colors.pine })
hl("Exception", { fg = colors.pine })
hl("PreProc", { fg = colors.iris })
hl("Include", { fg = colors.iris })
hl("Define", { fg = colors.iris })
hl("Macro", { fg = colors.iris })
hl("PreCondit", { fg = colors.iris })
hl("Type", { fg = colors.foam })
hl("StorageClass", { fg = colors.pine })
hl("Structure", { fg = colors.foam })
hl("Typedef", { fg = colors.foam })
hl("Special", { fg = colors.rose })
hl("SpecialChar", { fg = colors.rose })
hl("Tag", { fg = colors.foam })
hl("Delimiter", { fg = colors.subtle })
hl("SpecialComment", { fg = colors.iris, italic = true })
hl("Debug", { fg = colors.rose })
hl("Underlined", { fg = colors.foam, underline = true })
hl("Ignore", { fg = colors.muted })
hl("Error", { fg = colors.love, bold = true })
hl("Todo", { fg = colors.base, bg = colors.gold, bold = true })

-- Treesitter highlights
hl("@variable", { fg = colors.text })
hl("@variable.builtin", { fg = colors.love })
hl("@variable.parameter", { fg = colors.iris })
hl("@variable.member", { fg = colors.foam })
hl("@constant", { fg = colors.gold })
hl("@constant.builtin", { fg = colors.gold })
hl("@module", { fg = colors.foam })
hl("@string", { fg = colors.gold })
hl("@string.escape", { fg = colors.pine })
hl("@character", { fg = colors.gold })
hl("@number", { fg = colors.gold })
hl("@boolean", { fg = colors.rose })
hl("@function", { fg = colors.iris })
hl("@function.builtin", { fg = colors.love })
hl("@function.macro", { fg = colors.iris })
hl("@keyword", { fg = colors.pine })
hl("@keyword.function", { fg = colors.pine })
hl("@keyword.operator", { fg = colors.pine })
hl("@keyword.return", { fg = colors.pine })
hl("@operator", { fg = colors.subtle })
hl("@type", { fg = colors.foam })
hl("@type.builtin", { fg = colors.foam })
hl("@constructor", { fg = colors.foam })
hl("@tag", { fg = colors.foam })
hl("@tag.attribute", { fg = colors.iris })
hl("@tag.delimiter", { fg = colors.subtle })
hl("@punctuation.delimiter", { fg = colors.subtle })
hl("@punctuation.bracket", { fg = colors.muted })
hl("@comment", { link = "Comment" })

-- LSP highlights
hl("DiagnosticError", { fg = colors.love })
hl("DiagnosticWarn", { fg = colors.gold })
hl("DiagnosticInfo", { fg = colors.foam })
hl("DiagnosticHint", { fg = colors.iris })
hl("DiagnosticUnderlineError", { sp = colors.love, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = colors.gold, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = colors.foam, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = colors.iris, undercurl = true })

-- Git highlights
hl("GitSignsAdd", { fg = colors.foam })
hl("GitSignsChange", { fg = colors.rose })
hl("GitSignsDelete", { fg = colors.love })

-- Telescope highlights
hl("TelescopeNormal", { fg = colors.text, bg = colors.surface })
hl("TelescopeBorder", { fg = colors.muted, bg = colors.surface })
hl("TelescopePromptNormal", { fg = colors.text, bg = colors.overlay })
hl("TelescopePromptBorder", { fg = colors.muted, bg = colors.overlay })
hl("TelescopePromptTitle", { fg = colors.iris, bold = true })
hl("TelescopePreviewTitle", { fg = colors.foam, bold = true })
hl("TelescopeResultsTitle", { fg = colors.rose, bold = true })
hl("TelescopeSelection", { fg = colors.text, bg = colors.highlight_med, bold = true })
hl("TelescopeMatching", { fg = colors.love, bold = true })

-- Lualine highlights
hl("lualine_a_normal", { fg = colors.base, bg = colors.gold, bold = true })
hl("lualine_b_normal", { fg = colors.text, bg = colors.surface })
hl("lualine_c_normal", { fg = colors.subtle, bg = colors.base })
hl("lualine_a_insert", { fg = colors.base, bg = colors.foam, bold = true })
hl("lualine_a_visual", { fg = colors.base, bg = colors.iris, bold = true })
hl("lualine_a_replace", { fg = colors.base, bg = colors.love, bold = true })
hl("lualine_a_command", { fg = colors.base, bg = colors.pine, bold = true })

-- Airline highlights (if using vim-airline)
hl("airline_a", { fg = colors.base, bg = colors.gold, bold = true })
hl("airline_b", { fg = colors.text, bg = colors.surface })
hl("airline_c", { fg = colors.subtle, bg = colors.base })
