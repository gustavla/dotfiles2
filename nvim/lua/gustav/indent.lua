M = {}

M.setup_indent = function()
    local use2 = (
        vim.fn.expand('%:p'):match('.*src/www/onnx%-optimizer/.*%.cc') or
        vim.fn.expand('%:p'):match('.*src/www/onnx%-optimizer/.*%.h') or
        vim.fn.expand('%:p'):match('.*src/www/onnx%-simplifier/.*%.cpp') or
        vim.fn.expand('%:p'):match('.*src/www/onnx%-simplifier/.*%.h') or
        vim.fn.expand('%:p'):match('.*torch/.*%.cpp') or
        vim.fn.expand('%:p'):match('.*torch/.*%.h') or
        vim.fn.expand('%:p'):match('.*%.js') or
        vim.fn.expand('%:p'):match('.*%.ml')
    )
    if use2 then
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    else
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
    end
end

return M
