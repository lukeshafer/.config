local atWork = os.getenv("PC_CONTEXT") == "work"

return function()
	local tools = {
		------------------
		--     TOOLS    --
		------------------
		-- comment line with <leader>/
		--{ "preservim/nerdcommenter", event = "VeryLazy" },
		-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
		{
			"numToStr/Comment.nvim",
			opts = {
				-- add any options here
			},
			lazy = false,
		},

		-- color picker
		{
			"uga-rosa/ccc.nvim",
			event = "VeryLazy",
			config = function()
				require("ccc").setup({})
				vim.api.nvim_set_keymap("n", "cp", ":CccPick<CR>", { noremap = true })
			end,
		},

		-- auto-create brackets/parentheses
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {}, -- this is equalent to setup({}) function
		},

		-- autoclose/rename html tags
		{
			"windwp/nvim-ts-autotag",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},

		-- fuzzy finder
		{ "nvim-telescope/telescope.nvim", lazy = true },

		-- Terminal pane/tab/window handler
		{ "akinsho/toggleterm.nvim", event = "VeryLazy" },

		-- git diff viewer
		{
			"sindrets/diffview.nvim",
			event = "VeryLazy",
			dependencies = "nvim-lua/plenary.nvim",
		},

		-- move and jump to spots in code quickly
		{
			"ggandor/leap.nvim",
			event = "BufEnter",
			config = function()
				require("leap").add_default_mappings()
			end,
		},

		-- easier navigation between files
		-- {
		-- 	"ThePrimeagen/harpoon",
		-- 	event = "VeryLazy",
		-- 	dependencies = "nvim-lua/plenary.nvim",
		-- },

		-- floating file explorer
		{
			"nvim-tree/nvim-tree.lua",
			event = "VeryLazy",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		-- project-wide typescript checker
		-- {
		-- 	"dmmulroy/tsc.nvim",
		-- 	config = function()
		-- 		require("tsc").setup()
		-- 	end,
		-- },

		-- tools for surrounding text
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},

		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("ts_context_commentstring").setup({
					languages = {
						javascript = {
							__default = "// %s",
							jsx_element = "{/* %s */}",
							jsx_fragment = "{/* %s */}",
							jsx_attribute = "// %s",
							comment = "// %s",
						},
					},
				})
			end,
		},
	}

	-- personal PC only
	--if not atWork then
	---- copilot alternative but FREE (for now)
	--tools[#tools + 1] = {
	--"Exafunction/codeium.vim",
	--event = 'BufEnter',
	--config = function()
	--vim.g.codeium_no_tab_map = true
	---- Set Codeium Accept to <C-j> for insert mode
	--vim.keymap.set('i', '<C-j>', function()
	--return vim.fn['codeium#Accept']()
	--end, { expr = true })

	--vim.cmd('CodeiumDisable')
	--end,
	--}
	--end

	return tools
end
