# frozen_string_literal: true

require_relative './chess_pieces/pawn'

class Chess
  attr_accessor :board

  def initialize
    self.board = set_board
  end

  def set_board
    Array.new(8) { Array.new(8) }
  end

  def display_board
    column_strings = 'ABCDEFGH'
    board_string = "    1   2   3   4   5   6   7   8\n"
    board_string +=
      board.each.with_index.reduce("  +---+---+---+---+---+---+---+---+\n") do |string, (column, i)|
        string + "#{column_strings[i]} | #{column.map do |space|
                                             space ? space.symbol : ' '
                                           end.join(' | ')} |\n  +---+---+---+---+---+---+---+---+\n"
      end

    puts board_string
  end
end
