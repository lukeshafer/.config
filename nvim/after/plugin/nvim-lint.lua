local ok, lint = pcall(require, "lint")
if not ok then
	return
end

local utils = require("lksh.utils")

lint.linters.asl = {
	cmd = "aws",
	stdin = false,
	append_fname = false,
	args = {
		"stepfunctions",
		"validate-state-machine-definition",
		"--definition",
		function()
			return "file://" .. vim.api.nvim_buf_get_name(0)
		end,
		"--output",
		"json",
		"--severity",
		"WARNING",
		"--profile",
		"dev-crmi",
	},
	stream = "stdout",
	ignore_exitcode = true,
	parser = function(output, bufnr)
		if output == "" then
			return {}
		end
		local ok, decoded = pcall(vim.json.decode, output)
		if not ok or not decoded.diagnostics then
			return {}
		end

		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local diagnostics = {}

		for _, diag in ipairs(decoded.diagnostics) do
			local lnum = 0
			-- Resolve JSON pointer to a line number by finding the last key in the path
			if diag.location and diag.location ~= "" then
				local segments = vim.split(diag.location, "/", { trimempty = true })
				local target_key = segments[#segments]
				for i, line in ipairs(lines) do
					if line:find('"' .. target_key .. '"', 1, true) then
						lnum = i - 1
						break
					end
				end
			end

			table.insert(diagnostics, {
				lnum = lnum,
				col = 0,
				severity = diag.severity == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
				message = diag.message,
				source = "asl",
				code = diag.code,
			})
		end
		return diagnostics
	end,
}

lint.linters_by_ft = utils.use_in_context("work", {
	asl = { "asl" },
}, {})

local function is_cfn_template(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)

	-- Check if file is named template.yaml or is within a templates/ directory
	if name:match("/templates/") or name:match("/template%.yaml$") or name:match("/template%.yml$") then
		return true
	end

	-- Check if file contains AWSTemplateFormatVersion at the top level
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 30, false)
	for _, line in ipairs(lines) do
		if line:match("^AWSTemplateFormatVersion") then
			return true
		end
	end

	return false
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "TextChanged" }, {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.bo[bufnr].filetype

		if ft == "yaml" and is_cfn_template(bufnr) then
			lint.try_lint({ "cfn_lint" })
		else
			lint.try_lint()
		end
	end,
})
