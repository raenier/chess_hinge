class ChessPiece
  attr_accessor :color, :initial_move, :unicode_symbol

  def initialize(color)
    self.color = color
    self.initial_move = true
  end

  def symbol
    return unless unicode_symbol

    unicode_symbol[color.to_sym]
  end
end
