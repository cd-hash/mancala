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
    render()
    return next_turn(nextPos)
  end

  def next_turn(ending_cup_idx)
    #helper method to determine whether make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13 # if player ends in current players points cup return prompt current player always skips the opponents points cup
    return :switch if @cups[ending_cup_idx].length == 1 # if at the end of your turn there is only one stone in the cup then that stone was just placed there and does not count to a full cup
    return ending_cup_idx # if player ends on cup with stones in it return that cups location
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if (0..5).all? {|index| @cups[index].empty?} || (7..12).all? {|index| @cups[index].empty?}
    return false #base case
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
     if @cups[6].length > @cups[13].length
      return @player1
     else
      return @player2
     end
  end
end
