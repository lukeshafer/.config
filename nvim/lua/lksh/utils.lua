local M = {}
-- removed print_table -- use vim.inspect

---Runs a function only in the correct context
---@param ctx string
---@param true_val any If function, called and return value used. Otherwise returned directly.
---@param false_val any? Else branch -- used only if context is NOT ctx
function M.use_in_context(ctx, true_val, false_val)
	local env_ctx = os.getenv("PC_CONTEXT")
	local val = env_ctx == ctx and true_val or false_val
	if type(val) == "function" then
		return val()
	end
	return val
end

return M
