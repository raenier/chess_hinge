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
    @captured_pieces = {
      white: [],
      black: []
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

    checkmate = false
    until checkmate
      @players.each do |color, player|
        valid_start = false
        until valid_start
          print 'pick piece to move: '
          start_post = parse_input player
          start_piece = board.dig(*start_post)
          valid_start = start_piece&.color == color.to_s
        end

        valid_position = false
        until valid_position
          print 'new_position: '
          target_post = parse_input player
          target_piece = board.dig(*target_post)
          valid_position =
            start_piece.valid_move?(start_post, target_post, target_piece) &&
            inside_board?(target_post) &&
            no_obstacles?(start_post, target_post)
        end

        start_piece.initial_move = false
        move_and_capture(start_post, target_post)
        display_board
      end
      checkmate = checkmate?
    end
  end

  private

  def no_obstacles?(start_post, end_post)
    return true if board.dig(*start_post).is_a? Knight

    if start_post.first == end_post.first
      (start_post.last...end_post.last).step(start_post.last > end_post.last ? -1 : 1).each do |row|
        next if row == start_post.last

        return false if board.dig(end_post.first, row)
      end
    elsif start_post.last == end_post.last
      (start_post.first...end_post.first).step(start_post.first > end_post.first ? -1 : 1).each do |column|
        next if column == start_post.first

        return false if board.dig(column, end_post.last)
      end
    end

    true
  end

  def checkmate?
    false
  end

  def inside_board?(target_position)
    target_position.all? { |i| i >= 0 && i < 8 }
  end

  def move_and_capture(start, target)
    piece = board.dig(*start)
    target_piece = board.dig(*target)
    @captured_pieces[target_piece.color.to_sym] << target_piece if target_piece

    board[target[0]][target[1]] = piece
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
