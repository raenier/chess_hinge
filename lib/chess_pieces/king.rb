# frozen_string_literal: true

require_relative '../chess_piece'

class King < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2654", black: "\u265A" }
  end
end
