# frozen_string_literal: true

class Player
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def input
    $stdin.gets.chomp
  end
end
