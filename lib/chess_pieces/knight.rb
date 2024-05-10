# frozen_string_literal: true

require_relative '../chess_piece'

class Knight < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2658", black: "\u265E" }
  end
end
