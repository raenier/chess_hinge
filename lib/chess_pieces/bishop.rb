# frozen_string_literal: true

require_relative '../chess_piece'

class Bishop < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2657", black: "\u265D" }
  end
end
