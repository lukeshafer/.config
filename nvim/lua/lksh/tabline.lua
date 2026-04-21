local Tabline = {}

function Tabline.init()
	vim.opt.tabline = "%!v:lua.require('lksh.tabline').render()"

	vim.api.nvim_create_user_command("LSTablineSetTitle", function(opts)
		require("lksh.utils").print_table(opts)
		Tabline.set_title(opts.fargs[1])
	end, { nargs = 1 })

	require("lksh.keymaps").set_map("n", "<leader>t", ":LSTablineSetTitle ")
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
			dirs[1],
			"/../",
			dirs[dirs_len],
		}), bufnr
	end
end

local function tab_label(n)
	local title, bufnr = Tabline.get_title(n)

	local buf_opts = { scope = "local", buf = bufnr }
	local is_modified = vim.api.nvim_get_option_value("modified", buf_opts)

	local is_modifiable = vim.api.nvim_get_option_value("modifiable", buf_opts)

	local modified_str
	if is_modified then
		modified_str = "[+]"
	elseif is_modifiable then
		modified_str = "   "
	else
		modified_str = "[-]"
	end

	if title:len() == 0 then
		return "[unnamed]" .. modified_str
	end

	return title .. modified_str
end

function Tabline.render()
	local cwd = string.gsub(vim.fn.getcwd(), vim.fn.getenv("HOME"), "~")

	local tabline_table = { "%#Comment#", cwd, " " }

	local tab_count = vim.fn.tabpagenr("$")
	for i = 1, tab_count do
		if i == vim.fn.tabpagenr() then
			table.insert(tabline_table, "%#Pmenu#")
		else
			table.insert(tabline_table, "%#LineNr#")
		end

		table.insert(tabline_table, "%" .. i .. "T")
		table.insert(tabline_table, " " .. tab_label(i))
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
