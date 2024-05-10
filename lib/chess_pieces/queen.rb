# frozen_string_literal: true

require_relative '../chess_piece'

class Queen < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2655", black: "\u265B" }
  end
end
