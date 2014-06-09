require 'pry-byebug'
require 'time'

module Exercises
  # Exercise 0
  #  - Triples a given string `str`
  #  - Returns "nope" if `str` is "wishes"
  def self.ex0(str)
    # TODO
    if str == "wishes"
      return "nope"
    else
      return str * 3
    end
  end

  # Exercise 1
  #  - Returns the number of elements in the array
  def self.ex1(array)
    # TODO
    return array.size
  end

  # Exercise 2
  #  - Returns the second element of an array
  def self.ex2(array)
    # TODO
    return array[1]
  end

  # Exercise 3
  #  - Returns the sum of the given array of numbers
  def self.ex3(array)
    # TODO
    return array.inject(:+)
  end

  # Exercise 4
  #  - Returns the max number of the given array
  def self.ex4(array)
    # TODO
    return array.max
  end

  # Exercise 5
  #  - Iterates through an array and `puts` each element
  def self.ex5(array)
    # TODO
    output = ""
    array.each do |x| 
      output += "#{x}\n"
    end
    puts output
  end

  # Exercise 6
  #  - Updates the last item in the array to 'panda'
  #  - If the last item is already 'panda', update
  #    it to 'GODZILLA' instead
  def self.ex6(array)
    # TODO
    if array[-1].downcase != "panda"
      array[-1] = "panda"
    else
      array[-1] = "GODZILLA"
    end
    return array
  end

  # Exercise 7
  #  - If the string `str` exists in the array,
  #    add `str` to the end of the array
  def self.ex7(array, str)
    # TODO
    if array.include?(str)
      array << str
      return array
    else
      return array
    end
  end

  # Exercise 8
  #  - `people` is an array of hashes. Each hash is like the following:
  #    { :name => 'Bob', :occupation => 'Builder' }
  #    Iterate through `people` and print out their name and occupation.
  def self.ex8(people)
    # TODO
    people.each do |x|
      x.each do |k,v|
        puts v
      end
    end
  end

  # Exercise 9
  #  - Returns `true` if the given time is in a leap year
  #    Otherwise, returns `false`
  # Hint: Google for the wikipedia article on leap years
  def self.ex9(time)
    # TODO
    if time.year % 4 != 0
      return false
    elsif time.year % 100 != 0
      return true
    elsif time.year % 400 != 0
      return false
    else
      return true
    end
  end
end


class RPS
  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @win1 = 0
    @win2 = 0
  end

  def play(move1, move2)
    move1 = move1.downcase
    move2 = move2.downcase

    if @win1 == 2 || @win2 == 2
      return "Game is already over"
    end

    if move1 == "scissors"
      if move2 == "scissors"
        return "Tie"
      elsif move2 == "paper"
        @win1 += 1
        return @player1
      else
        @win2 += 1
        return @player2
      end
    elsif move1 == "paper"
      if move2 == "scissors"
        @win2 += 1
        return @player2
      elsif move2 == "paper"
        return "Tie"
      else
        @win1 +=1
        return @player1
      end
    else
      if move2 == "scissors"
        @win1 += 1
        return @player1
      elsif move2 == "paper"
        @win2 += 1
        return @player2
      else
        return "Tie"
      end
    end
  end
end


require 'io/console'
class RPSPlayer
  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again.
  def start
    puts "Name of player 1:"
    player1 = gets.chomp
    puts "Name of player 2:"
    player2 = gets.chomp
    game = RPS.new(player1, player2)
    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
    while (true)
      puts "Player 1 move: "
      move1 = STDIN.noecho(&:gets).chomp
      puts "Player 2 move: "
      move2 = STDIN.noecho(&:gets).chomp
      # move1.gsub("\n","")
      # move2.gsub("\n","")
      a = game.play(move1, move2)
      # binding.pry
      if a == "Game is already over"
        puts "Game is aleady over"
        break
      elsif a == "Tie"
        puts "That round was a tie with both players throwing #{move1}"
      else
        puts "#{a} won that round"
      end
    end      
  end
end


module Extensions
  # Extension Exercise
  #  - Takes an `array` of strings. Returns a hash with two keys:
  #    :most => the string(s) that occures the most # of times as its value.
  #    :least => the string(s) that occures the least # of times as its value.
  #  - If any tie for most or least, return an array of the tying strings.
  #
  # Example:
  #   result = Extensions.extremes(['x', 'x', 'y', 'z'])
  #   expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  #
  def self.extremes(array)
    # TODO
    hash = Hash.new(0)
    array.each do |x|
      hash[x] += 1
    end
    max = hash.max_by{|k,v| v}
    min = hash.min_by{|k,v| v}

    max_array = [max[0]]
    min_array =[min[0]]

    hash.each do |k,v|
      if v == max[1] && k != max[0]
          max_array << k
      end
      if v == min[1] && k != min[0]
          min_array << k
      end
    end

    max = max[0]
    min = min[0]
    if max_array.count > 1
      max = max_array
    end
    if min_array.count > 1
      min = min_array
    end
      
    return {most: max, least: min}


  end
end

