# frozen_string_literal: true

require_relative '../chess_piece'

class Knight < ChessPiece
  MOVES = [
    [2, 1],
    [2, -1],
    [1, 2],
    [1, -2],
    [-1, -2],
    [-1, 2],
    [-2, 1],
    [-2, -1]
  ].freeze

  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2658", black: "\u265E" }
  end

  def valid_move?(current_position, target_position, target_value)
    return false if target_value&.color == color
    return true if MOVES.include? [current_position.first - target_position.first,
                                   current_position.last - target_position.last]

    false
  end
end
