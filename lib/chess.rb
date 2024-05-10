require_relative './chess_pieces/pawn'

class Chess
  attr_accessor :board


  def initialize
    self.board = set_board
  end

  def set_board
    Array.new(8) { Array.new(8) }
  end
end
