# frozen_string_literal: true

require_relative '../chess_piece'

class King < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2654", black: "\u265A" }
  end

  def valid_move?(current_position, target_position, target_value)
    return false if target_value&.color == color

    if current_position.first == target_position.first && (current_position.last - target_position.last).abs == 1
      return true
    elsif current_position.last == target_position.last && (current_position.first - target_position.first).abs == 1
      return true
    elsif (current_position.first - target_position.first).abs == 1 && (current_position.last - target_position.last).abs == 1
      return true
    end

    false
  end
end
