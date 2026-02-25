class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

  def make_move(board)
    loop do
      puts "#{name} (#{piece}), choose a column (1-#{Board::COLS}):"
      input = gets.chomp
      unless input =~ /^\d+$/
        puts "Invalid input. Enter a number."
        next
      end
      column = input.to_i
      if column < 1 || column > Board::COLS
        puts "Column must be between 1 and #{Board::COLS}."
        next
      end
      pos = board.drop_piece(column, piece)
      return pos if pos
      puts "Column #{column} is full. Try another column."
    end
  end
end