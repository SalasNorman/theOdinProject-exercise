class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol = 'O')
    @name = name
    @symbol = symbol
  end

  def get_move
    STDIN.gets.chomp.to_i
  end
end
