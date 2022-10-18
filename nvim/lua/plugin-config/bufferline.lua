require("bufferline").setup{
	options = {
		right_mouse_command = nil,    -- can be a string | function, see "Mouse actions"
		middle_mouse_command = "bdelete! %d",    -- can be a string | function, see "Mouse actions"	
    color_icons = true,
    hover = {
      enabled = true,
      delay = 0,
      reveal = {'close'}
    },
		separator_style = "thick",
	}
}
