local Tabline = {}

function Tabline.init()
	vim.opt.tabline = "%!v:lua.require('lksh.tabline').render()"

	vim.api.nvim_create_user_command("LSTablineSetTitle", function(opts)
		-- require("lksh.utils").print_table(opts)
		Tabline.set_title(opts.fargs[1])
	end, { nargs = 1 })

	require("lksh.keymaps").set_map("n", "<leader>n", ":LSTablineSetTitle ")
end

---comment
---@param title string
---@param tabpagenr integer? Defaults to current tab
function Tabline.set_title(title, tabpagenr)
	vim.api.nvim_tabpage_set_var(tabpagenr or vim.fn.tabpagenr(), "LSTabName", title)
end

---@param tabpagenr integer? Defaults to current tab
---@return string,integer
function Tabline.get_title(tabpagenr)
	tabpagenr = tabpagenr or vim.fn.tabpagenr()
	local ok, title = pcall(vim.api.nvim_tabpage_get_var, tabpagenr, "LSTabName")

	local buflist = vim.fn.tabpagebuflist(tabpagenr)
	---@type integer
	local bufnr = buflist[vim.fn.tabpagewinnr(tabpagenr)]

	if ok and title then
		return title, bufnr
	end

	local bufname = vim.fn.bufname(bufnr)
	if bufname:len() == 0 then
		return "[unnamed]", bufnr
	end

	local dirs = vim.split(bufname, "/")

	local dirs_len = table.maxn(dirs)
	if dirs_len < 3 then
		return bufname, bufnr
	else
		return table.concat({
			dirs[dirs_len - 1],
			"/",
			dirs[dirs_len],
		}), bufnr
	end
end

function Tabline.render()
	-- local cwd = string.gsub(vim.fn.getcwd(), vim.fn.getenv("HOME"), "~")

	local tabline_table = {
		-- "%#LineNr#", cwd, " "
	}

	local tab_count = vim.fn.tabpagenr("$")
	for index = 1, tab_count do
		local highlight
		if index == vim.fn.tabpagenr() then
			highlight = "%#Pmenu#"
		else
			highlight = "%#Comment#"
		end

		local title, bufnr = Tabline.get_title(index)
		if title:len() == 0 then
			title = "[unnamed]"
		end

		local buf_opts = { scope = "local", buf = bufnr }

		local mod_mark = "  "
		if vim.api.nvim_get_option_value("modified", buf_opts) then
			mod_mark = " "
		elseif not vim.api.nvim_get_option_value("modifiable", buf_opts) then
			mod_mark = " "
		end

		table.insert(
			tabline_table,
			table.concat({
				highlight,
        " ",
				"%" .. index .. "T",
				index .. " ",
				title,
				mod_mark,
			})
		)
	end

	table.insert(tabline_table, "%#TabLineFill#%T")

	if tab_count > 1 then
		-- Include  to close current tab only if multiple tabs exist
		table.insert(tabline_table, "%=%#TabLine#%999X  ")
	end

	return table.concat(tabline_table)
end

LSTabline = Tabline

return Tabline
