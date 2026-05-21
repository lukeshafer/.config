--- Treesitter parser manager — replaces nvim-treesitter for parser installation.
--- Requires `tree-sitter` CLI to be installed.

local TSParsers = {}

--- Parser definitions: language -> { url, location? }
--- `location` is the subdirectory within the repo containing the grammar (for monorepos).
---@type table<string, { url: string, location: string? }>
TSParsers.parsers = {
	astro = { url = "https://github.com/virchau13/tree-sitter-astro" },
	bash = { url = "https://github.com/tree-sitter/tree-sitter-bash" },
	c = { url = "https://github.com/tree-sitter/tree-sitter-c" },
	css = { url = "https://github.com/tree-sitter/tree-sitter-css" },
	diff = { url = "https://github.com/the-mikedavis/tree-sitter-diff" },
	git_config = { url = "https://github.com/the-mikedavis/tree-sitter-git-config" },
	git_rebase = { url = "https://github.com/the-mikedavis/tree-sitter-git-rebase" },
	gitcommit = { url = "https://github.com/the-mikedavis/tree-sitter-gitcommit" },
	html = { url = "https://github.com/tree-sitter/tree-sitter-html" },
	javascript = { url = "https://github.com/tree-sitter/tree-sitter-javascript" },
	jsdoc = { url = "https://github.com/tree-sitter/tree-sitter-jsdoc" },
	json = { url = "https://github.com/tree-sitter/tree-sitter-json" },
	lua = { url = "https://github.com/tree-sitter-grammars/tree-sitter-lua" },
	luadoc = { url = "https://github.com/tree-sitter-grammars/tree-sitter-luadoc" },
	markdown = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
		location = "tree-sitter-markdown",
	},
	markdown_inline = {
		url = "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
		location = "tree-sitter-markdown-inline",
	},
	query = { url = "https://github.com/nvim-treesitter/tree-sitter-query" },
	regex = { url = "https://github.com/tree-sitter/tree-sitter-regex" },
	tsx = { url = "https://github.com/tree-sitter/tree-sitter-typescript", location = "tsx" },
	typescript = { url = "https://github.com/tree-sitter/tree-sitter-typescript", location = "typescript" },
	vim = { url = "https://github.com/neovim/tree-sitter-vim" },
	vimdoc = { url = "https://github.com/neovim/tree-sitter-vimdoc" },
	yaml = { url = "https://github.com/tree-sitter-grammars/tree-sitter-yaml" },
}

--- Where compiled parsers live (neovim's standard parser path).
local parser_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "parser")

--- Where we clone grammar repos for building.
local repos_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "ts-repos")

---@return string[]
function TSParsers.get_installed()
	local installed = {}
	for name in vim.fs.dir(parser_dir) do
		local lang = name:match("^(.+)%.so$") or name:match("^(.+)%.dylib$")
		if lang then
			table.insert(installed, lang)
		end
	end
	return installed
end

---@return string[]
function TSParsers.get_available()
	return vim.tbl_keys(TSParsers.parsers)
end

---@param lang string
---@return boolean
function TSParsers.is_installed(lang)
	local so = vim.fs.joinpath(parser_dir, lang .. ".so")
	local dylib = vim.fs.joinpath(parser_dir, lang .. ".dylib")
	return vim.uv.fs_stat(so) ~= nil or vim.uv.fs_stat(dylib) ~= nil
end

---@param cmd string[]
---@param opts vim.SystemOpts?
---@return vim.SystemCompleted
local function run(cmd, opts)
	local result = vim.system(cmd, opts or {}):wait()
	if result.code ~= 0 then
		error(string.format("Command failed: %s\n%s", table.concat(cmd, " "), result.stderr or ""))
	end
	return result
end

--- Install a parser for the given language. Synchronous.
---@param lang string
function TSParsers.install_sync(lang)
	local spec = TSParsers.parsers[lang]
	if not spec then
		return vim.notify("No parser defined for: " .. lang, vim.log.levels.WARN, { title = "ts-parsers" })
	end

	vim.fn.mkdir(repos_dir, "p")
	vim.fn.mkdir(parser_dir, "p")

	local repo_name = spec.url:match("([^/]+)$")
	local repo_path = vim.fs.joinpath(repos_dir, repo_name)

	-- Clone or pull
	if vim.uv.fs_stat(repo_path) then
		run({ "git", "-C", repo_path, "pull", "--ff-only", "--depth=1" })
	else
		run({ "git", "clone", "--depth=1", spec.url, repo_path })
	end

	-- Determine build directory
	local build_dir = repo_path
	if spec.location then
		build_dir = vim.fs.joinpath(repo_path, spec.location)
	end

	-- Build
	run({ "tree-sitter", "build", "-o", "parser.so" }, { cwd = build_dir })

	-- Install
	local built = vim.fs.joinpath(build_dir, "parser.so")
	local dest = vim.fs.joinpath(parser_dir, lang .. ".so")
	vim.uv.fs_copyfile(built, dest, { ficlone = true })
	os.remove(built)

	vim.notify("Installed parser: " .. lang, vim.log.levels.INFO, { title = "ts-parsers" })
end

--- Install a parser asynchronously via callback.
---@param lang string
---@param on_done? fun(err?: string)
function TSParsers.install(lang, on_done)
	on_done = on_done or function() end
	local spec = TSParsers.parsers[lang]
	if not spec then
		on_done("No parser defined for: " .. lang)
		return
	end

	vim.fn.mkdir(repos_dir, "p")
	vim.fn.mkdir(parser_dir, "p")

	local repo_name = spec.url:match("([^/]+)$")
	local repo_path = vim.fs.joinpath(repos_dir, repo_name)
	local build_dir = spec.location and vim.fs.joinpath(repo_path, spec.location) or repo_path

	local function do_build()
		vim.system({ "tree-sitter", "build", "-o", "parser.so" }, { cwd = build_dir }, function(result)
			vim.schedule(function()
				if result.code ~= 0 then
					return on_done("tree-sitter build failed: " .. (result.stderr or ""))
				end
				local built = vim.fs.joinpath(build_dir, "parser.so")
				local dest = vim.fs.joinpath(parser_dir, lang .. ".so")
				vim.uv.fs_copyfile(built, dest, { ficlone = true })
				os.remove(built)
				vim.notify("Installed parser: " .. lang, vim.log.levels.INFO, { title = "ts-parsers" })
				on_done(nil)
			end)
		end)
	end

	local git_cmd
	if vim.uv.fs_stat(repo_path) then
		git_cmd = { "git", "-C", repo_path, "pull", "--ff-only", "--depth=1" }
	else
		git_cmd = { "git", "clone", "--depth=1", spec.url, repo_path }
	end

	vim.system(git_cmd, {}, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				return on_done("git failed: " .. (result.stderr or ""))
			end
			do_build()
		end)
	end)
end

--- Install all defined parsers. Synchronous.
function TSParsers.install_all()
	for lang, _ in pairs(TSParsers.parsers) do
		local ok, err = pcall(TSParsers.install_sync, lang)
		if not ok then
			vim.notify("Failed: " .. lang .. " — " .. tostring(err), vim.log.levels.ERROR, { title = "ts-parsers" })
		end
	end
end

--- Update all installed parsers. Synchronous.
function TSParsers.update()
	for _, lang in ipairs(TSParsers.get_installed()) do
		if TSParsers.parsers[lang] then
			local ok, err = pcall(TSParsers.install_sync, lang)
			if not ok then
				vim.notify(
					"Update failed: " .. lang .. " — " .. tostring(err),
					vim.log.levels.ERROR,
					{ title = "ts-parsers" }
				)
			end
		end
	end
end

--- User commands
function TSParsers.create_commands()
	vim.api.nvim_create_user_command("TSInstall", function(opts)
		local lang = opts.fargs[1]
		if not lang then
			return vim.notify("Usage: TSInstall <lang>", vim.log.levels.WARN)
		end
		TSParsers.install(lang)
	end, {
		nargs = 1,
		complete = function()
			return TSParsers.get_available()
		end,
	})

	vim.api.nvim_create_user_command("TSInstallAll", function()
		TSParsers.install_all()
	end, {})

	vim.api.nvim_create_user_command("TSUpdate", function()
		TSParsers.update()
	end, {})
end

return TSParsers
