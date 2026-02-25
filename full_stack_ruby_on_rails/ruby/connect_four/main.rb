# class Board
#   ROWS = 6
#   COLS = 7

#   attr_reader :table

#   def initialize
#     @table = Array.new(ROWS) { Array.new(COLS, ".") }
#   end

# def display
#   puts (1..COLS).to_a.join(" ")
#   table.each do |row|
#     colored_row = row.map do |cell|
#       if cell == 'O'
#         Rainbow(cell).blue
#       elsif cell == 'X'
#         Rainbow(cell).red
#       else
#         cell
#       end
#     end
#     puts colored_row.join(" ")
#   end
# end

#   def drop_piece(column, piece)
#     column_index = column - 1
#     (ROWS - 1).downto(0) do |row|
#       if table[row][column_index] == "."
#         table[row][column_index] = piece
#         return [row, column_index]
#       end
#     end
#     nil # Column full
#   end

#   def full?
#     table.all? { |row| row.none? { |cell| cell == "." } }
#   end
# end

# class Player
#   attr_reader :name, :piece

#   def initialize(name, piece)
#     @name = name
#     @piece = piece
#   end

#   def make_move(board)
#     loop do
#       puts "#{name} (#{piece}), choose a column (1-#{Board::COLS}):"
#       input = gets.chomp
#       unless input =~ /^\d+$/
#         puts "Invalid input. Enter a number."
#         next
#       end
#       column = input.to_i
#       if column < 1 || column > Board::COLS
#         puts "Column must be between 1 and #{Board::COLS}."
#         next
#       end
#       pos = board.drop_piece(column, piece)
#       return pos if pos
#       puts "Column #{column} is full. Try another column."
#     end
#   end
# end

# class Computer
#   attr_reader :name, :piece

#   def initialize(piece = "O")
#     @name = "Computer"
#     @piece = piece
#   end

#   def make_move(board)
#     puts "#{name} (#{piece}) is thinking..."
#     sleep(2) # pause add effect
#     valid_columns = (1..Board::COLS).select do |col|
#       board.table[0][col - 1] == "."
#     end
#     column = valid_columns.sample
#     pos = board.drop_piece(column, piece)
#     puts "#{name} drops piece in column #{column}"
#     pos
#   end
# end

# class Checker
#   def self.win?(board, piece, last_pos)
#     row, col = last_pos
#     return true if check_direction(board, piece, row, col, 1, 0)   # vertical
#     return true if check_direction(board, piece, row, col, 0, 1)   # horizontal
#     return true if check_direction(board, piece, row, col, 1, 1)   # diagonal \
#     return true if check_direction(board, piece, row, col, 1, -1)  # diagonal /
#     false
#   end

#   def self.check_direction(board, piece, row, col, dr, dc)
#     count = 1
#     count += count_pieces(board, piece, row, col, dr, dc)
#     count += count_pieces(board, piece, row, col, -dr, -dc)
#     count >= 4
#   end

#   def self.count_pieces(board, piece, row, col, dr, dc)
#     r, c = row + dr, col + dc
#     count = 0
#     while r.between?(0, Board::ROWS-1) && c.between?(0, Board::COLS-1) && board.table[r][c] == piece
#       count += 1
#       r += dr
#       c += dc
#     end
#     count
#   end
# end

# class Game
#   def initialize
#     @board = Board.new
#     puts "Enter your name:"
#     name = gets.chomp
#     name = "Player" if name.strip.empty?
#     @player = Player.new(name, "X")
#     @computer = Computer.new("O")
#     @current_player = @player
#   end

#   def play
#     loop do
#       @board.display
#       last_pos = @current_player.make_move(@board)
#       if Checker.win?(@board, @current_player.piece, last_pos)
#         @board.display
#         puts "=== #{@current_player.name} wins! ==="
#         break
#       elsif @board.full?
#         @board.display
#         puts "=== It's a draw! ==="
#         break
#       else
#         switch_player
#       end
#     end
#   end

#   def switch_player
#     @current_player = (@current_player == @player) ? @computer : @player
#   end
# end

# Start the game
require 'rainbow'
require_relative 'lib/board'
require_relative 'lib/checker'
require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/player'

Game.new.play
