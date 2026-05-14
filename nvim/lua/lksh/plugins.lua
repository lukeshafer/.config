local utils = require("lksh.utils")
-- local git = require("lksh.git")

if not vim.version.range(">=0.12.0"):has(vim.version()) then
	vim.notify("Neovim plugins require version 0.12.0 or later.", vim.log.levels.ERROR)
	return
end

local Plugins = {}

function Plugins.init()
	local p = utils.parse_plugin_list({
		["nvim-mini/mini.nvim"] = utils.mini_modules({
			["mini.notify"] = {},
			["mini.colors"] = {},
			["mini.cursorword"] = {},
			["mini.git"] = {},
			["mini.icons"] = {},
			["mini.pairs"] = {},
			["mini.surround"] = {},
			["mini.files"] = {
				setup = function()
					local show_ignored = false

					local git_ignored = {}
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

					local hide_git_ignored_sort = function(entries)
						refresh_git_ignored(entries)

						return MiniFiles.default_sort(vim.tbl_filter(function(entry)
							return not check_is_git_ignored(entry.path)
						end, entries))
					end

					local function get_file_sort()
						if show_ignored then
							return require("mini.files").default_sort
						end

						return hide_git_ignored_sort
					end

					require("mini.files").setup({
            options = {
              permanent_delete = false,
              use_as_default_explorer = false,
            },
						mappings = {
							go_in = "L", -- swap go in plus to close explorer by default
							go_in_plus = "l",
						},
						content = {
							-- filter = get_filter(),
							highlight = function(fs_entry)
								if check_is_git_ignored(fs_entry.path) then
									return "Comment"
								else
									return MiniFiles.default_highlight(fs_entry)
								end
							end,
							sort = get_file_sort(),
						},
					})

					vim.keymap.set("n", "<leader>e", function()
						MiniFiles.open()
					end, { noremap = true, silent = true })

					vim.keymap.set("n", "<leader>E", function()
						MiniFiles.open(vim.api.nvim_buf_get_name(0))
					end, { noremap = true, silent = true })

					vim.api.nvim_create_autocmd({ "User" }, {
						pattern = "MiniFilesBufferCreate",
						callback = function(ev)
							local buf_id = ev.data.buf_id
							show_ignored = false

							-- Tweak left-hand side of mapping to your liking
							vim.keymap.set("n", "g.", function()
								show_ignored = not show_ignored
								MiniFiles.refresh({ content = { sort = get_file_sort() } })
							end, { buffer = buf_id })
						end,
					})

					-- local ns = vim.api.nvim_create_namespace("ls-mini-files-ns")
					-- vim.api.nvim_create_autocmd({ "User" }, {
					-- 	pattern = "MiniFilesBufferUpdate",
					-- 	callback = function(ev)
					-- 		local buf_id = ev.data.buf_id
					-- 		-- MiniFiles
					--
					-- 		local lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
					--
					-- 		git.refresh()
					--
					-- 		local count = 0
					-- 		vim.iter(ipairs(lines))
					-- 			:map(function(index, line)
					-- 				local fs_entry = MiniFiles.get_fs_entry(buf_id, index)
					-- 				if fs_entry == nil then
					-- 					return
					-- 				end
					--
					-- 				local s = git.get_status(fs_entry.path)[1]
					-- 				if s == nil then
					-- 					return
					-- 				end
					--
					-- 				local status_str = s.status
					--
					-- 				---@type string?
					-- 				local hl_group = nil
					-- 				if status_str == "modified" or status_str == "renamed" then
					-- 					hl_group = "MiniDiffSignChange"
					-- 				elseif
					-- 					status_str == "added"
					-- 					or status_str == "copied"
					-- 					or status_str == "untracked"
					-- 				then
					-- 					hl_group = "MiniDiffSignAdd"
					-- 				elseif status_str == "deleted" then
					-- 					hl_group = "MiniDiffSignDelete"
					-- 				elseif status_str then
					-- 					hl_group = "IncSearch"
					-- 				end
					--
					-- 				-- local char = status_str:sub(1, 1):upper() or " "
					-- 				-- if count == 0 then
					-- 				-- 	count = count + 1
					-- 				-- 	utils.print_table({
					-- 				-- 		index = index,
					-- 				-- 		line = line,
					-- 				-- 		entry = fs_entry,
					-- 				-- 		status = s,
					-- 				-- 		char = char,
					-- 				-- 		hl_group = hl_group,
					-- 				-- 	})
					-- 				-- end
					--
					-- 				local extid = vim.api.nvim_buf_set_extmark(buf_id, ns, index - 1, 0, {
					-- 					virt_text = { { char, hl_group } },
					-- 					virt_text_pos = "inline",
					-- 					end_col = string.len(line),
					-- 					hl_group = hl_group or MiniFiles.default_highlight(fs_entry),
					-- 					hl_eol = hl_group and true,
					-- 					--
					-- 				})
					-- 			end)
					-- 			:totable()
					--
					-- 		-- local paths = {}
					-- 		-- for index, line in ipairs(lines) do
					-- 		-- 	local fs_entry = MiniFiles.get_fs_entry(buf_id, index)
					-- 		-- 	local status = git.get_status(fs_entry.path)
					-- 		--
					-- 		-- 	-- if index == 1 then
					-- 		-- 	-- 	utils.print_table({
					-- 		-- 	-- 		index = index,
					-- 		-- 	-- 		line = line,
					-- 		-- 	-- 		entry = entry,
					-- 		-- 	-- 		status = status,
					-- 		-- 	-- 	})
					-- 		-- 	-- end
					-- 		--
					-- 		-- 	local status_str = status[1].status
					-- 		--
					-- 		-- 	---@type string?
					-- 		-- 	local hl_group = nil
					-- 		-- 	if status_str == "modified" or status_str == "renamed" then
					-- 		-- 		hl_group = "MiniDiffSignChange"
					-- 		-- 	elseif status_str == "added" or status_str == "copied" or status_str == "untracked" then
					-- 		-- 		hl_group = "MiniDiffSignAdd"
					-- 		-- 	elseif status_str == "deleted" then
					-- 		-- 		hl_group = "MiniDiffSignDelete"
					-- 		-- 	elseif status_str then
					-- 		-- 		hl_group = "IncSearch"
					-- 		-- 	end
					-- 		--
					-- 		-- 	---
					-- 		-- 	-- GitStatusName:
					-- 		-- 	--     | "modified"
					-- 		-- 	--     | "added"
					-- 		-- 	--     | "deleted"
					-- 		-- 	--     | "renamed"
					-- 		-- 	--     | "copied"
					-- 		-- 	--     | "untracked"
					-- 		-- 	--     | "ignored"
					-- 		-- 	--     | "unmerged"
					-- 		-- 	-- ```
					-- 		-- 	---
					-- 		-- 	---
					-- 		-- 	---
					-- 		-- 	local char = status and status[1] and status[1].status:sub(1, 1):upper() or " "
					-- 		-- 	local extid = vim.api.nvim_buf_set_extmark(buf_id, ns, index - 1, 0, {
					-- 		-- 		virt_text = { { char, hl_group } },
					-- 		-- 		virt_text_pos = "inline",
					-- 		-- 		end_col = string.len(line),
					-- 		-- 		hl_group = hl_group or MiniFiles.default_highlight(fs_entry),
					-- 		-- 		hl_eol = hl_group and true,
					-- 		-- 		--
					-- 		-- 	})
					-- 		-- end
					--
					-- 		-- utils.print_table(paths)
					-- 	end,
					-- })
				end,
			},
			["mini.hues"] = {
				setup = function()
					math.randomseed(utils.get_seed_from_string(vim.fn.getcwd()))

					require("mini.hues").setup({
						background = require("mini.colors").convert({
							l = vim.o.background == "dark" and 12 or 85,
							c = 3,
							h = math.random(180, 360),
						}, "hex"),
						foreground = require("mini.colors").convert({
							l = vim.o.background == "dark" and 87 or 10,
							c = 2,
							h = math.random(0, 360),
						}, "hex"),
						n_hues = 8,
						saturation = vim.o.background == "dark" and "medium" or "high",
						accent = "fg",
					})

					local kitty_pid = os.getenv("KITTY_PID")
					if kitty_pid ~= nil and kitty_pid ~= "" then
						vim.cmd([[
					         highlight Normal guibg=none
					         highlight NonText guibg=none
					         highlight Normal ctermbg=none
					         highlight NonText ctermbg=none
					       ]])
					end

					vim.g.colors_name = "randomhue"
				end,
			},
			["mini.indentscope"] = {
				setup = function()
					require("mini.indentscope").setup({
						draw = {
							delay = 0,
							animation = require("mini.indentscope").gen_animation.none(),
						},
						-- options = { indent_at_cursor = true },
						symbol = "▎",
					})
				end,
			},
			["mini.diff"] = {
				setup = function()
					require("mini.diff").setup({
						view = {
							priority = 1,
							style = "sign",
							signs = {
								-- add = "",
								add = "▎",
								change = "▎",
								delete = "▁",
							},
						},
					})

					vim.api.nvim_set_hl(0, "MiniDiffSignChange", {
						link = "diffFile",
					})

					vim.keymap.set("n", "<leader>g", function()
						MiniDiff.toggle_overlay(0)
					end, { noremap = true, silent = true })
				end,
			},
			["mini.completion"] = {
				setup = function()
					require("mini.completion").setup({})

					vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
					vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
				end,
			},
			["mini.pick"] = {
				setup = function()
					require("mini.pick").setup({})
					require("mini.extra").setup({})
					local keys = require("lksh.keymaps")

					keys.set_map("n", "ff", MiniPick.builtin.files)
					keys.set_map("n", "fg", MiniPick.builtin.grep_live)
					keys.set_map("n", "fb", MiniPick.builtin.buffers)
					keys.set_map("n", "fh", MiniPick.builtin.help)
					keys.set_map("n", "fm", MiniExtra.pickers.manpages)
				end,
			},
			["mini.hipatterns"] = {
				setup = function()
					require("mini.hipatterns").setup({
						highlighters = {
							fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
							hack = { pattern = "HACK", group = "MiniHipatternsHack" },
							todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
							note = { pattern = "NOTE", group = "MiniHipatternsNote" },
							hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
						},
					})
				end,
			},
			["mini.map"] = {
				setup = function()
					local map = require("mini.map")

					map.setup({
						window = {
							width = 4,
							-- show_integration_count = false,
						},
						integrations = {
							map.gen_integration.builtin_search(),
							map.gen_integration.diagnostic({
								error = "DiagnosticFloatingError",
								warn = "DiagnosticFloatingWarn",
								info = "DiagnosticFloatingInfo",
								hint = "DiagnosticFloatingHint",
							}),
							-- map.gen_integration.diff(),
						},
					})
					-- MiniMap.open()

					vim.keymap.set("n", "<leader>m", function()
						MiniMap.toggle()
					end, { noremap = true, silent = true })
				end,
			},
		}),
    ["stevearc/oil.nvim"] = {
      setup = {

      }
    },
		["stevearc/conform.nvim"] = {
			setup = function()
				local conform = require("conform")

				conform.setup({
					formatters_by_ft = {
						lua = { "stylua" },
						javascript = utils.js_formatter,
						typescript = utils.js_formatter,
						javascriptreact = utils.js_formatter,
						typescriptreact = utils.js_formatter,
						jsx = utils.js_formatter,
						tsx = utils.js_formatter,
						astro = utils.js_formatter,
						json = { "fixjson" },
						-- java = { "google-java-format" },
						-- go = { "golines", "goimports", "gofumpt" },
						soql = { "sleek" },
						markdown = { "cbfmt" },
					},
				})

				vim.keymap.set("n", "<leader>f", function()
					conform.format({ timeout_ms = 2000, lsp_fallback = true })
				end, { noremap = true, silent = true })
			end,
		},
		["williamboman/mason.nvim"] = {
			setup = true,
		},
		["neovim/nvim-lspconfig"] = {},
		["nvim-treesitter/nvim-treesitter"] = {
			setup = function()
				require("nvim-treesitter").install({})

				-- require("nvim-treesitter.parsers").pico8 = {
				-- 	install_info = {
				-- 		url = "https://github.com/paradoxskin/tree-sitter-pico8.git",
				-- 		files = { "src/parser.c" },
				-- 	},
				-- 	filetype = "pico8",
				-- }
				--
				--     vim.treesitter.language.register('pico8', { 'p8' })

				vim.api.nvim_create_autocmd("PackChanged", {
					callback = function()
						require("nvim-treesitter").update()
					end,
				})
			end,
		},
		["windwp/nvim-ts-autotag"] = {
			setup = true,
		},
		["nvim-treesitter/nvim-treesitter-context"] = {},
	})

	-- utils.print_table(p)
	vim.pack.add(p.plugin_list)
	p.setup()
end

return Plugins
