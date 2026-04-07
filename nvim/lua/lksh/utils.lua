local M = {}

if os.getenv("PC_CONTEXT") then
	M.js_formatter = {}
else
	M.js_formatter = { "prettier" }
end

---@param text string
function M.get_seed_from_string(text)
	local value = 0
	local prev = 3
	local MAX = 1e7

	for c in text:gmatch(".") do
		local b = c:byte()

		if prev > b then
			value = b * (value + prev * b)
		elseif prev < b then
			value = prev * (value - prev * b)
		end

		value = math.fmod(value, MAX)
		prev = b
	end

	return value
end

function M.gen_random_base_colors()
	local convert = require("mini.colors").convert

	local bgL = vim.o.background == "dark" and math.random(12, 12) or math.random(85, 85) -- used to be 12
	local bgH = math.random(180, 360)
	local bgC = 3

	local fgL = vim.o.background == "dark" and 87 or 10
	local fgC = 2
	local fgH = math.random(0, 360)

	return {
		background = convert({ l = bgL, c = bgC, h = bgH }, "hex"),
		foreground = convert({ l = fgL, c = fgC, h = fgH }, "hex"),
	}
end

---@param t table
---@param depth integer
---@return string
local function _format_table(t, depth)
	local indent = string.format("%" .. depth .. "s", "")
	local table_str_lines = {}

	for k, v in pairs(t) do
		if type(v) == "table" then
			table.insert(
				table_str_lines,
				table.concat({
					indent,
					k,
					" = {\n",
					_format_table(v, depth + 2),
					"\n",
					indent,
					"}",
				})
			)
		else
			table.insert(
				table_str_lines,
				table.concat({
					indent,
					k,
					" = ",
					tostring(v),
				})
			)
		end
	end

	return table.concat(table_str_lines, "\n")
end

---Converts formatted table to string
---@param t table
---@return string
function M.format_table(t)
	return _format_table(t, 0)
end

---Prints table
---@param t table
function M.print_table(t)
	print(M.format_table(t))
end

---Runs a function only in the correct context
---@param ctx string
---@param fn function|nil
---@param el_fn function? Else function -- run only if context is NOT ctx
function M.run_in_context(ctx, fn, el_fn)
	local env_ctx = os.getenv("PC_CONTEXT")
	if env_ctx == ctx and fn then
		return fn()
	elseif el_fn then
		return el_fn()
	end
end

M.HOME_DIR = os.getenv("HOME") or os.getenv("USERPROFILE")

if vim.uv.os_uname().sysname == "Windows_NT" then
	M.IS_WINDOWS = true
elseif not os.getenv("HOME") and os.getenv("USERPROFILE") then
	M.IS_WINDOWS = true
else
	M.IS_WINDOWS = false
end

---@class PluginDef
---@field src string
---@field deps? string[]
---@field setup? boolean|table|function

---@param url string
local function resolve_plugin_url(url)
	return url:find("://") and url or "https://github.com/" .. url
end

---@param name string
---@return string
local function resolve_plugin_module(name)
	local m = name:match("[^/]+$"):gsub("%.nvim$", "")
	return m
end

---Light wrapper around vim.pack.add to mark dependencies
---@param plugins (PluginDef|string)[]
function M.load_plugins(plugins)
	---@type string[]
	local plugin_list = {}
	---@type function[]
	local setup_fns = {}
	for _, p in ipairs(plugins) do
		if type(p) == "string" then
			table.insert(plugin_list, resolve_plugin_url(p))
		else
			for _, dep in ipairs(p.deps or {}) do
				table.insert(plugin_list, resolve_plugin_url(dep))
			end
			table.insert(plugin_list, resolve_plugin_url(p.src))
			local setup = p.setup
			if type(setup) == "function" then
				table.insert(setup_fns, setup)
			elseif setup == true then
				table.insert(setup_fns, function()
					require(resolve_plugin_module(p.src)).setup({})
				end)
			elseif type(setup) == "table" then
				table.insert(setup_fns, function()
					require(resolve_plugin_module(p.src)).setup(setup)
				end)
			end
		end
	end

	vim.pack.add(plugin_list)

	for _, setup_fn in ipairs(setup_fns) do
		setup_fn()
	end
end

---@class MiniPluginEntry
---@field [1] string The plugin name
---@field setup? fun() Optional setup function

---@alias MiniPluginList (string|MiniPluginEntry)[]

---@param plugins MiniPluginList
---@return PluginDef
function M.mini_nvim_modules(plugins)
	return {
		src = "nvim-mini/mini.nvim",
		setup = function()
			for _, value in ipairs(plugins) do
				if type(value) == "string" then
					require("mini." .. value).setup({})
				else
					value.setup()
				end
			end
		end,
	}
end

return M
