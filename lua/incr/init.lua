local M = {}

local function getSelection()
	local block = vim.fn.visualmode() == ""
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local start_row = s_start[2] - 1
	local start_col = s_start[3] - 1
	local end_row = s_end[2] - 1
	local end_col = s_end[3]
	if end_col == 2147483647 then
		end_col = end_col - 1
	end

	local lines = {}
	if block then
		for row = start_row, end_row do
			-- in visual block, we need to grab just the start_col to end_col from each line
			table.insert(lines, vim.api.nvim_buf_get_text(0, row, start_col, row, end_col, {})[1])
		end
	else
		lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
	end
	return {
		lines = lines,
		startRow = start_row,
		startCol = start_col,
		endRow = end_row,
		endCol = end_col,
		block = block
	}
end

local function writeLines(selection)
	for i, l in ipairs(selection.lines) do
		local row = selection.startRow + i - 1
		local rowStr = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
		local rowFront = string.sub(rowStr, 1, selection.startCol)
		local rowEnd = string.sub(rowStr, selection.endCol + 1)
		vim.api.nvim_buf_set_lines(0, row, row + 1, false, { rowFront .. l .. rowEnd })
	end
end

local function _incrIntBy(delta)
	local selection = getSelection()
	local start = tonumber(selection.lines[1])
	for i = 2, #selection.lines do
		selection.lines[i] = tostring(start + ((i - 1) * delta))
	end
	writeLines(selection)
end

function M.incrInt()
	_incrIntBy(1)
end

function M.incrIntBy()
	vim.ui.input({ prompt = "Delta:" }, function(delta)
		_incrIntBy(tonumber(delta))
	end)
end

return M
