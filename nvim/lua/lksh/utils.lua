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
	local MAX = 1000

	for c in text:gmatch(".") do
		local b = c:byte()

		value = b * (value + prev * b)
		-- if prev > b then
		-- elseif prev < b then
		-- 	value = prev * (value - prev * b)
		-- end

		value = math.fmod(value, MAX)
		prev = b
	end

	return value
end

function M.gen_random_base_colors()
	local convert = require("mini.colors").convert

	local bgL = vim.o.background == "dark" and math.random(11, 13) or math.random(83, 87)
	local bgH = math.random(180, 360)
	local bgC = math.random(2, 3)

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
function M.plugin(url)
	return url:find("://") and url or "https://github.com/" .. url
end

---@param name string
---@return string
local function resolve_plugin_module(name)
	return name:match("[^/]+$"):gsub("%.nvim$", "")
end

---@param setup boolean|function|table|nil
---@param src string
---@return function|nil
local function resolve_plugin_setup_fn(setup, src)
	if type(setup) == "function" then
		return setup
	elseif setup == true then
		return function()
			require(resolve_plugin_module(src)).setup({})
		end
	elseif type(setup) == "table" then
		return function()
			require(resolve_plugin_module(src)).setup(setup)
		end
	else
		return nil
	end
end

---@class PluginConfig
---@field deps? string[]
---@field setup? boolean|table|function

--- Takes a declarative input for plugins, dependencies, and setup functions
--- and outputs a list of plugin URLs and a callback to run said setup functions.
---@param plugin_input_list table<string,PluginConfig>
function M.parse_plugin_list(plugin_input_list)
	---@type string[]
	local plugin_output_list = {}
	---@type function[]
	local setup_fns = {}

	for plugin_name, plugin_config in pairs(plugin_input_list) do
		for _, dep in ipairs(plugin_config.deps or {}) do
			table.insert(plugin_output_list, M.plugin(dep))
		end

		table.insert(plugin_output_list, M.plugin(plugin_name))

		local setup_fn = resolve_plugin_setup_fn(plugin_config.setup, plugin_name)
		if setup_fn then
			table.insert(setup_fns, setup_fn)
		end
	end

	return {
		plugin_list = plugin_output_list,
		setup = function()
			for _, setup_fn in ipairs(setup_fns) do
				setup_fn()
			end
		end,
	}
end

-- ---Light wrapper around vim.pack.add to mark dependencies
-- ---@param plugins (PluginDef|string)[]
-- function M.load_plugins(plugins)
-- 	---@type string[]
-- 	local plugin_list = {}
-- 	---@type function[]
-- 	local setup_fns = {}
-- 	for _, p in ipairs(plugins) do
-- 		if type(p) == "string" then
-- 			table.insert(plugin_list, resolve_plugin_url(p))
-- 		else
-- 			for _, dep in ipairs(p.deps or {}) do
-- 				table.insert(plugin_list, resolve_plugin_url(dep))
-- 			end
-- 			table.insert(plugin_list, resolve_plugin_url(p.src))
-- 			local setup = p.setup
-- 			if type(setup) == "function" then
-- 				table.insert(setup_fns, setup)
-- 			elseif setup == true then
-- 				table.insert(setup_fns, function()
-- 					require(resolve_plugin_module(p.src)).setup({})
-- 				end)
-- 			elseif type(setup) == "table" then
-- 				table.insert(setup_fns, function()
-- 					require(resolve_plugin_module(p.src)).setup(setup)
-- 				end)
-- 			end
-- 		end
-- 	end
--
-- 	vim.pack.add(plugin_list)
--
-- 	for _, setup_fn in ipairs(setup_fns) do
-- 		setup_fn()
-- 	end
-- end

----@class MiniPluginEntry
----@field [1] string The plugin name
----@field setup? fun() Optional setup function

---@class MiniPluginTableEntry
---@field setup? fun() Optional setup function

----@alias MiniPluginList (string|MiniPluginEntry)[]
---@alias MiniPluginTable table<string, MiniPluginTableEntry>

---@param plugins MiniPluginTable
---@return PluginConfig
function M.mini_modules(plugins)
	return {
		setup = function()
			for name, value in pairs(plugins) do
				if value.setup then
					value.setup()
				else
					require(name).setup({})
				end
			end
		end,
	}
end

function M.mini_files_help_init()
	local obj = {}

	local show_ignored = false
	local default_sort = require("mini.files").default_sort
	local default_highlight = require("mini.files").default_highlight

	local git_ignored = {}

	function obj.toggle_ignored()
		show_ignored = not show_ignored
	end

	local function check_is_git_ignored(fs_path)
		return vim.tbl_contains(git_ignored, fs_path)
	end

	local function refresh_git_ignored(entries)
		local result = vim.system({ "git", "check-ignore", "--stdin" }, {
			stdin = table.concat(
				vim.tbl_map(function(entry)
					return entry.path
				end, entries),
				"\n"
			),
		}):wait()

		git_ignored = vim.split(result.stdout, "\n")
	end

	function obj.get_sort_fn()
		if show_ignored then
			return default_sort
		end

		return function(entries)
			refresh_git_ignored(entries)

			return default_sort(vim.tbl_filter(function(entry)
				return not check_is_git_ignored(entry.path)
			end, entries))
		end
	end

	function obj.highlight_fn(fs_entry)
		if check_is_git_ignored(fs_entry.path) then
			return "Comment"
		else
			return default_highlight(fs_entry)
		end
	end

	return obj
end

return M
