#1
class Greeting
  def greet(message)
    puts message
  end
end

class Hello #< Greeting
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

#hello = Hello.new
# hello.hi  #"Hello"

#hello2 = Hello.new
# hello2.bye  #undefined method error

#hello3 = Hello.new
# hello3.greet  #expects 1 argument, got 0

# hello4 = Hello.new
# hello4.greet("Goodbye") # "Goodbye" <- overwrites default argument

Hello.hi # .hi is not a class method. until it changed

#3
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

putz = AngryCat.new(10, "putz")
chap = AngryCat.new(3, "chap")
putz.name
chap.age

#4
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    puts "I am a #{@type} cat."
  end
end

franz = Cat.new("tabby")
franz.to_s

#5
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
#tv.manufacturer # error - manufacturer is a Class method not an object method
tv.model # valid object method

Television.manufacturer # valid class method
#Television.model # error - model is an object method, not a class method

#6
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    # self.age += 1
    @age += 1
  end
end

#7
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    # return "I want to turn on the light with a brightness level of super high and a colour of green"
    "I want to turn on the light with a brightness level of #{@brightness} and a colour of #{@color}" # don't need 'return' and used the instance variables.
  end

end