-- Custom theme for Lush.nvim
local lush = require('lush')
local hsl = lush.hsl

local theme_blue_base = hsl(210, 34, 63)
local theme_beige_base = hsl(35, 24, 80)
local theme_yellow_base = hsl(50, 66, 80)
local theme_red_base = hsl(13, 73, 42)
local theme_green_base = hsl(143, 15, 35)
local theme_gray = hsl(52, 10, 10)

--- @diagnostic disable: undefined-global
return lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		-- Define what vims Normal highlight group should look like
		Normal { bg = theme_blue_base.darken(83), fg = theme_beige_base },
		-- And make whitespace slightly darker than normal.
		Whitespace { fg = Normal.fg.darken(40).saturate(-80) },
		-- And make comments look the same, but with italic text
		Comment { Whitespace, gui = "italic" },
		Identifier { fg = theme_blue_base.lighten(45).saturate(40), gui = "italic" },
		Constant { fg = theme_red_base.lighten(40).desaturate(30) },
		Statement { fg = theme_red_base.lighten(50).mix(theme_blue_base.lighten(10), 60).saturate(30) },
		Function { fg = theme_yellow_base },
		PMenu { bg = Normal.bg.lighten(5) },
		Error { fg = Normal.fg.lighten(10), bg = theme_red_base, gui = "bold" },
		Special { fg = theme_green_base.lighten(50) },
		NonText { fg = Identifier.fg.darken(50), gui = "bold" },
		SpecialKey { NonText },
		Directory { fg = Normal.fg },
		Type { Special },
		PreProc { Statement },
		Question { PreProc },
		MoreMsg { Question },
		IblIndent { fg = Whitespace.fg.mix(Normal.bg, 80) },
		IblWhitespace { IblIndent },
		IblScope { IblIndent },
		WinSeparator {  fg = Whitespace.fg.mix(Normal.bg, 60)  },

		-- HTML / JSX
		sym"@tag.delimiter" { fg = Whitespace.fg },
		sym"@tag" { fg = theme_blue_base.darken(10) },
		sym"@tag.attribute" { fg = Identifier.fg },

		-- SYNTAX
		sym"@variable" { fg = Identifier.fg },
		sym"@operator" { fg = Normal.fg.darken(10) },
		sym"@keyword" { fg = Statement.fg },
		sym"@keyword.function" { fg = theme_blue_base },
		sym"@punctuation" { fg = Normal.fg },
		sym"@function" { fg = Statement.fg },
		sym"@lsp.typemod.type" { fg = theme_blue_base },
		sym"@lsp.typemod.function.defaultLibrary" { fg = Statement.fg },

		-- DIAGNOSTICS
		DiagnosticError { fg = Error.bg.lighten(30), gui = "bold" },
		DiagnosticWarn { fg = theme_yellow_base.mix(theme_red_base, 20), gui = "bold" },
		DiagnosticInfo { fg = theme_blue_base.lighten(30), gui = "bold" },
		DiagnosticHint { fg = theme_beige_base.darken(30), gui = "bold" },
		DiagnosticOk { fg = theme_green_base, gui = "bold" },


		-- COLUMNS
		ColumnBase { bg = Normal.bg.lighten(2) },
		SignColumn { ColumnBase, fg = Identifier.fg.darken(50), gui = "bold" },
		FoldColumn { SignColumn },
		DiffAdd { fg = theme_green_base, gui = "bold", ColumnBase },
		DiffDelete { fg = theme_red_base, gui = "bold", ColumnBase },
		DiffChange { fg = theme_yellow_base, gui = "bold", ColumnBase },

		-- LINES
		Cursor { fg = Normal.bg, bg = theme_blue_base.lighten(10) },
		CursorLine { bg = Normal.bg.lighten(5) },   -- lighten() can also be called via li()
		CursorColumn { CursorLine },                 -- CursorColumn is linked to CursorLine
		Visual { fg = Normal.bg, bg = theme_blue_base }, -- Try pressing v and selecting some text
		LineNr { fg = theme_blue_base.da(40), gui = "italic", bg = ColumnBase.bg },
		LineNrBelow { fg = LineNr.fg.da(40), ColumnBase },
		LineNrAbove { LineNrBelow },
		CursorLineNr { LineNr, fg = CursorLine.bg.mix(Normal.fg, 50) },
		IlluminatedWordRead { bg = CursorLine.bg.darken(10) },

		-- STATUSLINES
		StatusLine { bg = Normal.bg.lighten(10), fg = Normal.fg.darken(20) },
		StatusLineNC { StatusLine, fg = Normal.fg.darken(40) },

		-- Search
		search_base { bg = theme_yellow_base, fg = theme_gray },
		MatchParen { bg = theme_green_base.darken(20), fg = theme_yellow_base, gui = "bold" },
		Search { search_base },
		IncSearch { bg = search_base.bg.ro(-20), fg = search_base.fg.da(90) },
	}
end)
