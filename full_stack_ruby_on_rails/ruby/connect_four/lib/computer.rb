class Computer
  attr_reader :name, :piece

  def initialize(piece = "O")
    @name = "Computer"
    @piece = piece
  end

  def make_move(board)
    puts "#{name} (#{piece}) is thinking..."
    sleep(2) # pause add effect
    valid_columns = (1..Board::COLS).select do |col|
      board.table[0][col - 1] == "."
    end
    column = valid_columns.sample
    pos = board.drop_piece(column, piece)
    puts "#{name} drops piece in column #{column}"
    pos
  end
end
