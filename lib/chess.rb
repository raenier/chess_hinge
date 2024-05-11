# frozen_string_literal: true

require_relative './chess_pieces/pawn'
require_relative './chess_pieces/rook'
require_relative './chess_pieces/knight'
require_relative './chess_pieces/bishop'
require_relative './chess_pieces/king'
require_relative './chess_pieces/queen'
require_relative './player'

class Chess
  attr_accessor :board

  def initialize
    self.board = set_board
    preset_pieces
    @players = {
      white: nil,
      black: nil
    }
  end

  def set_board
    Array.new(8) { Array.new(8) }
  end

  def preset_pieces
    board.each_with_index do |column, index|
      column[-2] = Pawn.new('white')
      column[1] = Pawn.new('black')

      if [0, 7].include?(index)
        column[-1] = Rook.new('white')
        column[0] = Rook.new('black')
      elsif [1, 6].include?(index)
        column[-1] = Knight.new('white')
        column[0] = Knight.new('black')
      elsif [2, 5].include?(index)
        column[-1] = Bishop.new('white')
        column[0] = Bishop.new('black')
      elsif index == 3
        column[-1] = Queen.new('white')
        column[0] = Queen.new('black')
      elsif index == 4
        column[-1] = King.new('white')
        column[0] = King.new('black')
      end
    end
  end

  def display_board
    system('clear')

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

  def start
    display_board
    puts "\n  Let Start the chess_match!"

    print "\nPlayer with white pieces, enter your NAME: "
    @players[:white] = Player.new($stdin.gets.chomp)
    print "\nPlayer with black pieces, enter your NAME: "
    @players[:black] = Player.new($stdin.gets.chomp)

    puts "#{@players[:white].name} starts the game:"

    @players.each do |_color, player|
      print 'pick piece to move: '
      start_post = parse_input player
      print 'new_position: '
      target_post = parse_input player

      move(start_post, target_post)
      display_board
    end
  end

  private

  def move(start, target)
    board[target[0]][target[1]] = board.dig(*start)
    board[start[0]][start[1]] = nil
  end

  def parse_input(player)
    valid = false

    until valid
      input = player.input
      valid = valid_input? input
    end

    input
      .upcase
      .gsub(/[A-Z]/) { |c| c.ord - 64 }
      .split('')
      .map { |c| c.to_i - 1 }
  end

  def valid_input?(input)
    return true if input.size == 2 && !integer?(input[0]) && integer?(input[-1])

    false
  end

  def integer?(string)
    string.to_i.to_s == string
  end
end
