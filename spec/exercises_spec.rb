require 'pry-byebug'
require './exercises.rb'


describe 'exercises' do

  describe 'ex0' do
    it 'triples given string' do
      answer = Exercises.ex0("string")
      expect(answer).to eq("stringstringstring")
    end
    it 'returns nope if string is "wishes"' do
      answer = Exercises.ex0("wishes")
      expect(answer).to eq("nope")
    end
  end

  describe 'ex1' do
    it 'return number of elements in the array' do
      arr1 = Exercises.ex1([1,2,5,4,8,4,2,6])
      arr2 = Exercises.ex1([1,4,8,4,2,6])
      expect(arr1).to eq(8)
      expect(arr2).to eq(6)
    end
  end

  describe 'ex2' do
    it 'returns the second element of an array' do
      array = [1,5,2,8,3,6]
      element = Exercises.ex2(array)
      expect(element).to eq(5)
    end
  end

  describe 'ex3' do
    it 'returns the sum of the given array' do
      array = [1,2,3,4,5]
      sum = Exercises.ex3(array)
      expect(sum).to eq(15)
    end
  end

  describe 'ex4' do
    it 'returns the mac number of a given array' do
      array = [2,7,4,8,3,10,25,3,7]
      max = Exercises.ex4(array)
      expect(max).to eq(25)
    end
  end

  describe 'ex5' do
    it 'iterates through array and puts each element' do
      array = [1,2,3]
      # STDOUT.should_receive(:puts).with("1\n2\n3\n")
      # STDOUT.should_receive(:puts).with(2)
      # STDOUT.should_receive(:puts).with(3)
      expect(STDOUT).to receive(:puts).with("1\n2\n3\n")
      output = Exercises.ex5(array)
    end
  end

  describe 'ex6' do
    it 'updates last item to panda' do
      array1 =["Sachin","Winston","random"]
      array2 =["Sachin","Winston","panda"]
      answer = Exercises.ex6(array1)

      expect(answer).to eq(array2)
    end

    it 'updates to GODZILLA if already panda' do
      array1 =["Sachin","Winston","panda"]
      array2 =["Sachin","Winston","GODZILLA"]
      answer = Exercises.ex6(array1)

      expect(answer).to eq(array2)
    end
  end

  describe 'ex7' do
    it 'if str exists in array, add str to end of array' do
      array1 =["Sachin","Winston","panda"]
      array2 =["Sachin","Winston","panda","Winston"]
      answer = Exercises.ex7(array1,"Winston")

      expect(answer).to eq(array2)      
    end

    it 'if str doesnt exist in array, return array' do
      array2 =["Sachin","Winston","panda","Winston"]
      answer = Exercises.ex7(array2,"baller")

      expect(answer).to eq(array2)
    end
  end

  describe 'ex8' do
    it 'iterates through array of people hash and puts out name and occupation' do
      array = [
        { :name => 'Bob', :occupation => 'Builder' },
        { :name => 'Sachin', :occupation => 'Coder' },
        { :name => 'Winston', :occupation => 'Coder' }
      ]
      expect(STDOUT).to receive(:puts).with("Bob")
      expect(STDOUT).to receive(:puts).with("Builder")
      expect(STDOUT).to receive(:puts).with("Sachin")
      expect(STDOUT).to receive(:puts).with("Coder")
      expect(STDOUT).to receive(:puts).with("Winston")
      expect(STDOUT).to receive(:puts).with("Coder")
      Exercises.ex8(array)

    end
  end

  describe 'ex9' do
    it 'returns true if given time is in a leap year' do
      time = Time.parse("June 6 2012")
      answer = Exercises.ex9(time)
      expect(answer).to eq(true)
    end
    it 'returns false if given time is not in a leap year' do
      time = Time.parse("June 6 2013")
      answer = Exercises.ex9(time)
      expect(answer).to eq(false)
    end
  end
end


describe 'RPS Game' do
  describe 'RPS' do
    before do
      @game = RPS.new("Sachin", "Winston")
    end
    describe '.initialize' do
      it 'initializes with names of player 1 and 2' do
        expect(@game.player1).to eq("Sachin")
        expect(@game.player2).to eq("Winston")
      end
    end
    describe 'play' do
      before do
        @n1 = @game.play("rock","scissors")
        @n2 = @game.play("scissors", "rock")
        @n3 = @game.play("rock", "rock")
        @n4 = @game.play("paper", "rock")
        @n5 = @game.play("paper", "scissors")
      end
      it 'returns winner of each round' do
        expect(@n1).to eq("Sachin")
        expect(@n2).to eq("Winston")
        expect(@n4).to eq("Sachin")
      end
      it 'returns tie if no winner' do
        expect(@n3).to eq("Tie")
      end
      it 'returns "Game is already over" if game is over' do
        expect(@n5).to eq("Game is already over")
      end
    end
  end
end

describe 'extensions' do
  describe 'accepts array of strings' do
    it 'returns a hash with most and least occured strings in array' do
      array = ['x', 'x', 'x', 'z', 'y', 'y']
      answer = {most: "x", least: "z"}
      expect(Extensions.extremes(array)).to eq(answer)
    end
    it 'returns a hash with and array of most and least occured strings in array if a tie' do
      array = ['x', 'x', 'y', 'z', 'y', 'x', 'z']
      answer = {most: "x", least: ["y", "z"]}
      expect(Extensions.extremes(array)).to eq(answer)
    end
  end
end
