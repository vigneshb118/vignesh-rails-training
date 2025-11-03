board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
word = "ABCCED"

matched = false
init_row, init_col = [0, 0]
row = init_row
col = init_col
row_col_arr = []
word_index = 0
all_parsed = false
has_match = false

while(1)
	if board[row][col] == word[word_index]
	    row_col_arr << [row, col]
	    if word_index+1 == word.length
	        has_match = true
		elsif col+1 < board[0].length && board[row][col+1] == word[word_index+1]
			col += 1
			has_match = true
		elsif col - 1 >= 0 && !row_col_arr.include?([row, col-1]) && board[row][col-1] == word[word_index+1]
			col -= 1
			has_match = true
		elsif row+1 < board.length && board[row+1][col] == word[word_index+1]
			row += 1
			has_match = true
		elsif row - 1 >= 0 && !row_col_arr.include?([row-1, col]) && board[row-1][col] == word[word_index+1]
			row -= 1
			has_match = true
		else
			has_match = false
		end
	else
	    has_match = false
	end
	
	p row, col, row_col_arr, has_match, init_row, init_col, word_index, "ASDFSasdfasdfasdf"

	if has_match
		word_index += 1
		if word_index >= word.length
			res = true
			break
		else
			if all_parsed
				res = false
				break
			end
		end
		has_match = false
	else
	    word_index = 0
		row_col_arr = []
		init_col += 1
		if init_col >= board[0].length
			init_col = 0
			init_row += 1
			if init_row >= board.length
				all_parsed = true
				break 
			end
		end
		row = init_row
		col = init_col
	end
end

if all_parsed && res
    p res
else
    p false
end
