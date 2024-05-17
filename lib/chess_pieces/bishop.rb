# frozen_string_literal: true

require_relative '../chess_piece'

class Bishop < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2657", black: "\u265D" }
  end

  def valid_move?(current_position, target_position, target_value)
    return false if target_value&.color == color
    if (current_position.first - target_position.first).abs == (current_position.last - target_position.last).abs
      return true
    end

    false
  end
end
