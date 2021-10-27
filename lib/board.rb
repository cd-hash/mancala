require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1 #player 1 is always side 1
    @player2 = name2 #player 2 is always side 2
    @cups = Array.new(14) {Array.new(4)}
    place_stones()
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    for cupIdx in 0...@cups.length
      if cupIdx == 6 || cupIdx == 13
        @cups[cupIdx].clear
      else
        @cups[cupIdx].fill(:stone)
      end
    end
  end

  def valid_move?(start_pos)
    if (start_pos < 0 || start_pos > 13)
      raise 'Invalid starting cup'
    end
    if @cups[start_pos].empty?
      raise 'Starting cup is empty'
    end
  end

  def make_move(start_pos, current_player_name)
    counter = 1
    nextPos = start_pos
    until @cups[start_pos].empty?
      nextPos += 1
      # debugger
      if nextPos > 13
        nextPos = 0
      end
      if (current_player_name == @player1 && nextPos == 13) || (current_player_name == @player2 && nextPos == 6)
        next
      else
        stone = @cups[start_pos].pop()
        @cups[nextPos] << stone
      end
    end
    # render()
    next_turn(nextPos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    # if player ends in own cup return prompt 
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
