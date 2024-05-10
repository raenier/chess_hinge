# frozen_string_literal: true

require_relative '../chess_piece'

class Rook < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2656", black: "\u265C" }
  end
end
