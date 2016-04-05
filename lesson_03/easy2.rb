#1
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
#2
class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"] # these will supercede the choices method from the inherited class.
  end
end

oracle = Oracle.new
p oracle.predict_the_future
trip = RoadTrip.new
p trip.predict_the_future

#3
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors.inspect
p HotSauce.ancestors.inspect

#4
class BeesWax
  attr_accessor :type, # add getter and setter AIO
  def initialize(type)
    @type = type
  end

  # def type        the accessor replicates this and the one below
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

#5
excited_dog = "excited dog" # local variable
@excited_dog = "excited dog" # instance variable
@@excited_dog = "excited dog" # class variable

#6
class Television
  def self.manufacturer #class method because of self 
    # method logic
  end

  def model
    # method logic
  end
end
Television.manufacturer # calling the class method manufacturer

#7
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1  # adds one to @@cats_count each time a Cat object is initialized
  end

  def self.cats_count
    @@cats_count
  end
end

milly = Cat.new("dumb")
frank = Cat.new("easy")
p Cat.cats_count

#8
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # adding < Game will allow Bingo class to inherit methods from Game class
  def rules_of_play
    #rules of play
  end
end

#9
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play    # Will supersede the play method inherited from Game class
    "Staring in Bingo Class."
  end
end

now = Bingo.new
p now.play

# OOP means that more variables can be available in more places.
# Code can be organized easily
# Inheritence means code can be DRY
# Ojects mean things can be considered more abstractly