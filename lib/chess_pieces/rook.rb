# frozen_string_literal: true

require_relative '../chess_piece'

class Rook < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2656", black: "\u265C" }
  end

  def valid_move?(current_position, target_position, target_value)
    return false if current_position.first != target_position.first && current_position.last != target_position.last
    return false if target_value&.color == color

    true
  end
end
