class ChessPiece
  attr_accessor :color, :initial_move

  def initialize(color)
    self.color = color
    self.initial_move = true
  end
end
