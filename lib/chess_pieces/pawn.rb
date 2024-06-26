# frozen_string_literal: true

require_relative '../chess_piece'

class Pawn < ChessPiece
  def initialize(color)
    super(color)
    self.unicode_symbol = { white: "\u2659", black: "\u265F" }
  end

  def valid_move?(current_position, target_position, target_value = nil)
    return false if (target_position[0] - current_position[0]).abs > 1

    if target_position[0] == current_position[0]
      if (current_position[1] - target_position[1]).abs == 1 ||
         (current_position[1] - target_position[1]).abs == 2 && initial_move
        return true
      end
    elsif target_value && target_value.color != color
      return true
    end

    false
  end
end
