# chess game in ruby!!
# run with: bundle exec ruby chess.rb

require 'bundler/setup'
require 'colorize'

# -----------------------------------------------
# CONSTANTS
# -----------------------------------------------

PIECES = {
  :white_king   => "♔",
  :white_queen  => "♕",
  :white_rook   => "♖",
  :white_bishop => "♗",
  :white_knight => "♘",
  :white_pawn   => "♙",
  :black_king   => "♚",
  :black_queen  => "♛",
  :black_rook   => "♜",
  :black_bishop => "♝",
  :black_knight => "♞",
  :black_pawn   => "♟",
  :empty        => " "
}

COL_LETTERS = {
  "a" => 0, "b" => 1, "c" => 2, "d" => 3,
  "e" => 4, "f" => 5, "g" => 6, "h" => 7
}

# directions reused by multiple pieces
STRAIGHT_DIRECTIONS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
DIAGONAL_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
ALL_DIRECTIONS      = STRAIGHT_DIRECTIONS + DIAGONAL_DIRECTIONS
KNIGHT_JUMPS        = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

# -----------------------------------------------
# BOARD SETUP
# -----------------------------------------------

def make_starting_board
  board = Array.new(8) { Array.new(8, :empty) }

  # black back row
  back_row = [:black_rook, :black_knight, :black_bishop, :black_queen,
              :black_king, :black_bishop, :black_knight, :black_rook]
  back_row.each_with_index { |piece, col| board[0][col] = piece }

  # pawns
  8.times { |col| board[1][col] = :black_pawn }
  8.times { |col| board[6][col] = :white_pawn }

  # white back row
  white_row = [:white_rook, :white_knight, :white_bishop, :white_queen,
               :white_king, :white_bishop, :white_knight, :white_rook]
  white_row.each_with_index { |piece, col| board[7][col] = piece }

  return board
end

# -----------------------------------------------
# DRAWING THE BOARD
# -----------------------------------------------

def draw_board(board, selected_square = nil, valid_moves = [])
  puts ""
  puts "    a  b  c  d  e  f  g  h".light_yellow

  8.times do |row|
    row_num = 8 - row
    print " #{row_num} ".light_yellow

    8.times do |col|
      piece       = board[row][col]
      symbol      = PIECES[piece]
      is_light    = (row + col) % 2 == 0
      current_pos = [row, col]

      bg_color = pick_bg_color(current_pos, selected_square, valid_moves, is_light)
      text     = color_piece(symbol, piece, bg_color)

      print text
    end

    print " #{row_num}".light_yellow
    puts ""
  end

  puts "    a  b  c  d  e  f  g  h".light_yellow
  puts ""
end

def pick_bg_color(pos, selected, valid_moves, is_light)
  if pos == selected
    :green
  elsif valid_moves.include?(pos)
    :yellow
  elsif is_light
    :light_white
  else
    :blue
  end
end

def color_piece(symbol, piece, bg_color)
  if piece.to_s.start_with?("white")
    " #{symbol} ".colorize(:color => :white, :background => bg_color)
  elsif piece.to_s.start_with?("black")
    " #{symbol} ".colorize(:color => :black, :background => bg_color)
  else
    "   ".colorize(:background => bg_color)
  end
end

# -----------------------------------------------
# PIECE HELPERS
# -----------------------------------------------

def empty?(piece)
  piece == :empty
end

def players_piece?(piece, player)
  piece.to_s.start_with?(player.to_s)
end

def enemy_piece?(piece, player)
  other = player == :white ? "black" : "white"
  piece.to_s.start_with?(other)
end

def piece_type(piece)
  piece.to_s.gsub("white_", "").gsub("black_", "")
end

def on_board?(r, c)
  r.between?(0, 7) && c.between?(0, 7)
end

# -----------------------------------------------
# MOVE RULES
# -----------------------------------------------

def get_valid_moves(board, row, col, player)
  piece = board[row][col]

  case piece_type(piece)
  when "pawn"   then get_pawn_moves(board, row, col, player)
  when "rook"   then get_sliding_moves(board, row, col, player, STRAIGHT_DIRECTIONS)
  when "bishop" then get_sliding_moves(board, row, col, player, DIAGONAL_DIRECTIONS)
  when "queen"  then get_sliding_moves(board, row, col, player, ALL_DIRECTIONS)
  when "knight" then get_jump_moves(board, row, col, player, KNIGHT_JUMPS)
  when "king"   then get_jump_moves(board, row, col, player, ALL_DIRECTIONS)
  else []
  end
end

# rook, bishop, queen all slide along directions until blocked
def get_sliding_moves(board, row, col, player, directions)
  moves = []

  directions.each do |dr, dc|
    r = row + dr
    c = col + dc

    while on_board?(r, c)
      if empty?(board[r][c])
        moves << [r, c]
      elsif enemy_piece?(board[r][c], player)
        moves << [r, c]
        break
      else
        break  # blocked by own piece
      end
      r += dr
      c += dc
    end
  end

  return moves
end

# knight and king both "jump" to specific offsets (no sliding)
def get_jump_moves(board, row, col, player, jumps)
  moves = []

  jumps.each do |dr, dc|
    r = row + dr
    c = col + dc
    if on_board?(r, c) && (empty?(board[r][c]) || enemy_piece?(board[r][c], player))
      moves << [r, c]
    end
  end

  return moves
end

def get_pawn_moves(board, row, col, player)
  moves = []

  if player == :white
    direction    = -1  # white moves up the board
    starting_row = 6
  else
    direction    = 1   # black moves down the board
    starting_row = 1
  end

  # one step forward
  new_row = row + direction
  if on_board?(new_row, col) && empty?(board[new_row][col])
    moves << [new_row, col]

    # two steps forward from starting row
    if row == starting_row
      two_row = row + (direction * 2)
      moves << [two_row, col] if empty?(board[two_row][col])
    end
  end

  # diagonal captures
  [-1, 1].each do |dc|
    r = row + direction
    c = col + dc
    if on_board?(r, c) && enemy_piece?(board[r][c], player)
      moves << [r, c]
    end
  end

  return moves
end

# -----------------------------------------------
# GAME LOGIC
# -----------------------------------------------

def king_captured?(board, player)
  king = player == :white ? :white_king : :black_king

  8.times do |row|
    8.times do |col|
      return false if board[row][col] == king
    end
  end

  return true  # king not found on board = it was captured
end

def check_pawn_promotion(board)
  8.times do |col|
    if board[0][col] == :white_pawn
      board[0][col] = :white_queen
      puts "White pawn promoted to Queen!".colorize(:green)
    end

    if board[7][col] == :black_pawn
      board[7][col] = :black_queen
      puts "Black pawn promoted to Queen!".colorize(:green)
    end
  end
end

def notation_to_pos(notation)
  return nil if notation.length != 2

  letter = notation[0]
  number = notation[1].to_i

  return nil if COL_LETTERS[letter].nil? || !number.between?(1, 8)

  col = COL_LETTERS[letter]
  row = 8 - number

  return [row, col]
end

# -----------------------------------------------
# INPUT HANDLING
# -----------------------------------------------

def handle_input(board, current_player)
  print "Enter move (e.g. 'e2 e4'): "
  input = gets.chomp.strip.downcase

  return :quit if input == "quit" || input == "exit"
  return :help if input == "help"

  parts = input.split(" ")

  if parts.length != 2
    puts "ERROR: Please enter two squares like 'e2 e4'".colorize(:red)
    sleep(1.5)
    return :invalid
  end

  from = notation_to_pos(parts[0])
  to   = notation_to_pos(parts[1])

  if from.nil? || to.nil?
    puts "ERROR: Invalid square! Use letters a-h and numbers 1-8".colorize(:red)
    sleep(1.5)
    return :invalid
  end

  from_row, from_col = from
  piece = board[from_row][from_col]

  if empty?(piece)
    puts "ERROR: No piece on that square!".colorize(:red)
    sleep(1.5)
    return :invalid
  end

  unless players_piece?(piece, current_player)
    puts "ERROR: That's not your piece!".colorize(:red)
    sleep(1.5)
    return :invalid
  end

  to_row, to_col = to
  valid_moves = get_valid_moves(board, from_row, from_col, current_player)

  unless valid_moves.include?([to_row, to_col])
    puts "ERROR: That move is not allowed for that piece!".colorize(:red)
    sleep(1.5)
    return :invalid
  end

  return [from, to]
end

# -----------------------------------------------
# UI
# -----------------------------------------------

def print_welcome
  system("clear") rescue system("cls")
  puts "================================".colorize(:cyan)
  puts "       RUBY CHESS GAME          ".colorize(:cyan)
  puts "================================".colorize(:cyan)
  puts ""
  puts "How to play:".colorize(:light_yellow)
  puts "  - Type moves like: e2 e4"
  puts "  - First coordinate = piece to move"
  puts "  - Second coordinate = where to move"
  puts "  - Type 'quit' to exit"
  puts "  - Type 'help' to see this again"
  puts ""
  puts "Uses: colorize gem (via Bundler)".colorize(:light_black)
  puts ""
end

def show_turn(player)
  if player == :white
    puts "White's turn ♔".colorize(:white)
  else
    puts "Black's turn ♚".colorize(:cyan)
  end
end

def print_winner(winner, move_count)
  puts ""
  puts "=================================".colorize(:cyan)
  puts "  #{winner} wins!! Game over!   ".colorize(:yellow)
  puts "  (in #{move_count} moves)       ".colorize(:yellow)
  puts "=================================".colorize(:cyan)
end

# -----------------------------------------------
# MAIN GAME LOOP
# -----------------------------------------------

def play_chess
  print_welcome

  board          = make_starting_board
  current_player = :white
  move_count     = 0

  loop do
    draw_board(board)
    show_turn(current_player)

    result = handle_input(board, current_player)

    next  if result == :invalid
    next  if result == :help && print_welcome

    if result == :quit
      puts "Thanks for playing!".colorize(:green)
      break
    end

    from, to          = result
    from_row, from_col = from
    to_row,   to_col   = to

    # make the move
    captured_piece            = board[to_row][to_col]
    board[to_row][to_col]     = board[from_row][from_col]
    board[from_row][from_col] = :empty
    move_count += 1

    unless empty?(captured_piece)
      puts "Captured: #{PIECES[captured_piece]}".colorize(:magenta)
      sleep(0.5)
    end

    check_pawn_promotion(board)

    other_player = current_player == :white ? :black : :white

    if king_captured?(board, other_player)
      draw_board(board)
      print_winner(current_player.to_s.capitalize, move_count)
      break
    end

    current_player = other_player
  end
end

# start game
play_chess