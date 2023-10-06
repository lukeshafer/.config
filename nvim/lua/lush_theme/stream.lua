local lush = require('lush')
local hsl = lush.hsl

local theme_blue_base = hsl(210, 34, 63)
local theme_beige_base = hsl(35, 24, 80)
local theme_yellow_base = hsl(50, 66, 80)
local theme_red_base = hsl(13, 73, 42)
local theme_green_base = hsl(143, 15, 35)
local theme_gray = hsl(52, 10, 10)

print("test")
print(theme_blue_base)
--- @diagnostic disable: undefined-global
return lush(function()
	return {
		-- Define what vims Normal highlight group should look like
		Normal { bg = theme_blue_base.darken(83), fg = theme_beige_base },
		-- And make whitespace slightly darker than normal.
		Whitespace { fg = Normal.fg.darken(40).saturate(-80) },
		-- And make comments look the same, but with italic text
		Comment { Whitespace, gui = "italic" },
		Identifier { fg = theme_blue_base, gui = "italic" },
		Statement { fg = theme_green_base.lighten(50) },
		Special { fg = theme_yellow_base },
		PMenu { bg = Normal.bg.lighten(5) },
		Error { fg = Normal.fg.lighten(10), bg = theme_red_base, gui = "bold" },
		Constant { fg = theme_red_base.lighten(50) },

		-- COLUMNS
		SignColumn { fg = Identifier.fg.darken(50), gui = "bold" },
		FoldColumn { SignColumn },
		DiffAdd { fg = theme_green_base, gui = "bold" },
		DiffDelete { fg = theme_red_base, gui = "bold" },
		DiffChange { fg = theme_yellow_base, gui = "bold" },

		-- LINES
		Cursor { fg = Normal.bg, bg = Identifier.fg.lighten(10) },
		CursorLine { bg = Normal.bg.lighten(10) }, -- lighten() can also be called via li()
		CursorColumn { CursorLine },               -- CursorColumn is linked to CursorLine
		Visual { fg = Normal.bg, bg = Identifier.fg }, -- Try pressing v and selecting some text
		LineNr { fg = Identifier.fg.da(40), gui = "italic" },
		LineNrBelow { fg = LineNr.fg.da(40) },
		LineNrAbove { LineNrBelow },
		CursorLineNr { LineNr, fg = CursorLine.bg.mix(Normal.fg, 50) },

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
