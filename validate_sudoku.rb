def validate_lines(arr)
  arr.all? do |row|
    nums = row.flatten.reject { |e| e == "." }
    nums.length == nums.uniq.length
  end
end

def validate_matrix(arr)
  subgrids = arr.each_slice(3).flat_map do |row_block|
    row_block.transpose.each_slice(3).map(&:transpose)
  end

  validate_lines(subgrids)
end

def valid_sudoku?(board)
  return false unless validate_lines(board)
  return false unless validate_lines(board.transpose)
  return false unless validate_matrix(board)

  true
end

board =
  [
    ["5","3","1",".","7",".",".",".","2"],
    ["6",".",".","1","9","5",".","2","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
  ]

p valid_sudoku?(board)
