---@type vim.lsp.Config
return {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		local plugin_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt")
    local mini_dir = vim.fs.joinpath(plugin_dir, "mini.nvim", "lua", "mini")

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fs.joinpath(plugin_dir, "nvim-treesitter", "lua"),
					vim.fs.joinpath(mini_dir, "notify.lua"),
					vim.fs.joinpath(mini_dir, "colors.lua"),
					vim.fs.joinpath(mini_dir, "cursorword.lua"),
					vim.fs.joinpath(mini_dir, "git.lua"),
					vim.fs.joinpath(mini_dir, "icons.lua"),
					vim.fs.joinpath(mini_dir, "pairs.lua"),
					vim.fs.joinpath(mini_dir, "surround.lua"),
					vim.fs.joinpath(mini_dir, "extra.lua"),
					vim.fs.joinpath(mini_dir, "colors.lua"),
					vim.fs.joinpath(mini_dir, "hues.lua"),
					vim.fs.joinpath(mini_dir, "indentscope.lua"),
					vim.fs.joinpath(mini_dir, "diff.lua"),
					vim.fs.joinpath(mini_dir, "completion.lua"),
					vim.fs.joinpath(mini_dir, "pick.lua"),
					vim.fs.joinpath(mini_dir, "hipatterns.lua"),
					vim.fs.joinpath(mini_dir, "map.lua"),
					-- vim.fn.stdpath("data").."/site/pack/core"
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
}
