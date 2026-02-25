class Checker
  def self.win?(board, piece, last_pos)
    row, col = last_pos
    return true if check_direction(board, piece, row, col, 1, 0)   # vertical
    return true if check_direction(board, piece, row, col, 0, 1)   # horizontal
    return true if check_direction(board, piece, row, col, 1, 1)   # diagonal \
    return true if check_direction(board, piece, row, col, 1, -1)  # diagonal /
    false
  end

  def self.check_direction(board, piece, row, col, dr, dc)
    count = 1
    count += count_pieces(board, piece, row, col, dr, dc)
    count += count_pieces(board, piece, row, col, -dr, -dc)
    count >= 4
  end

  def self.count_pieces(board, piece, row, col, dr, dc)
    r, c = row + dr, col + dc
    count = 0
    while r.between?(0, Board::ROWS-1) && c.between?(0, Board::COLS-1) && board.table[r][c] == piece
      count += 1
      r += dr
      c += dc
    end
    count
  end
end