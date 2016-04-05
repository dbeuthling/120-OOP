# 1 They are all objects and you can find class with the .class method

#2
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!" #3 - the self.class will include the class of the object in the string
  end
end

class Car
  include Speed #added
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
    include Speed #added
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

car = Car.new
car.go_fast
truck = Truck.new
truck.go_fast

#4
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
butters = AngryCat.new

#5
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name # instance variable indicated by @ symbol
  end
end

tomato = Fruit.new("red")
cheese = Pizza.new("large")
p cheese.instance_variables
p tomato.instance_variables


#6
class Cube
  attr_accessor :volume # added
  def initialize(volume)
    @volume = volume
  end
end

square = Cube.new("50")
p square.volume
p square.to_s #7

#8
class Cat1
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 12
  end

  def make_one_year_older
    self.age += 1 #self refers to the instance of the object that is calling this method
  end
end

plop = Cat1.new("annoying")
p plop.make_one_year_older

#9
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count # self refers to the Cat class
    @@cats_count
  end
end

#10
class Bag
  attr_accessor :color
  def initialize(color, material)
    @color = color
    @material = material
  end
end

tote = Bag.new("brown", "canvas") # need to include both arguments to initiate a new object
p tote.color