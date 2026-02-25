class Board
  ROWS = 6
  COLS = 7

  attr_reader :table

  def initialize
    @table = Array.new(ROWS) { Array.new(COLS, ".") }
  end

def display
  puts (1..COLS).to_a.join(" ")
  table.each do |row|
    colored_row = row.map do |cell|
      if cell == 'O'
        Rainbow(cell).blue
      elsif cell == 'X'
        Rainbow(cell).red
      else
        cell
      end
    end
    puts colored_row.join(" ")
  end
end

  def drop_piece(column, piece)
    column_index = column - 1
    (ROWS - 1).downto(0) do |row|
      if table[row][column_index] == "."
        table[row][column_index] = piece
        return [row, column_index]
      end
    end
    nil # Column full
  end

  def full?
    table.all? { |row| row.none? { |cell| cell == "." } }
  end
end