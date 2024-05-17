# frozen_string_literal: true

require_relative '../chess_piece'

class Queen < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2655", black: "\u265B" }
  end

  def valid_move?(current_position, target_position, target_value)
    return false if target_value&.color == color

    if (current_position.first - target_position.first).abs == (current_position.last - target_position.last).abs
      return true
    elsif current_position.first == target_position.first || current_position.last == target_position.last
      return true
    end

    false
  end
end
