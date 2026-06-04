local ok, lint = pcall(require, "lint")
if not ok then return end

lint.linters.asl = {
  cmd = "aws",
  stdin = false,
  append_fname = false,
  args = {
    "stepfunctions", "validate-state-machine-definition",
    "--definition", function() return "file://" .. vim.api.nvim_buf_get_name(0) end,
    "--output", "json",
    "--severity", "WARNING",
    "--profile", "dev-crmi",
  },
  stream = "stdout",
  ignore_exitcode = true,
  parser = function(output, bufnr)
    if output == "" then return {} end
    local ok, decoded = pcall(vim.json.decode, output)
    if not ok or not decoded.diagnostics then return {} end

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
        severity = diag.severity == "ERROR"
          and vim.diagnostic.severity.ERROR
          or vim.diagnostic.severity.WARN,
        message = diag.message,
        source = "asl",
        code = diag.code,
      })
    end
    return diagnostics
  end,
}

lint.linters_by_ft = {
  yaml = { "cfn_lint" },
  asl = { "asl" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter", "TextChanged" }, {
  callback = function()
    lint.try_lint()
  end,
})
