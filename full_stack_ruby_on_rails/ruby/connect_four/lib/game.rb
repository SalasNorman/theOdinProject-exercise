class Game
  def initialize
    @board = Board.new
    puts "Enter your name:"
    name = gets.chomp
    name = "Player" if name.strip.empty?
    @player = Player.new(name, "X")
    @computer = Computer.new("O")
    @current_player = @player
  end

  def play
    loop do
      @board.display
      last_pos = @current_player.make_move(@board)
      if Checker.win?(@board, @current_player.piece, last_pos)
        @board.display
        puts "=== #{@current_player.name} wins! ==="
        break
      elsif @board.full?
        @board.display
        puts "=== It's a draw! ==="
        break
      else
        switch_player
      end
    end
  end

  def switch_player
    @current_player = (@current_player == @player) ? @computer : @player
  end
end