# class Animal
#   def speak
#     "Hello!"
#   end
# end

# class GoodDog < Animal
#   attr_accessor :name

#   def initialize(n)
#     self.name = n
#   end

#   def speak
#     super + "#{self.name} says woof!"
#   end

# end

# class Cat < Animal
# end

# sparky = GoodDog.new("Sparky")
# paws = Cat.new
# puts sparky.speak
# puts paws.speak

module Walkable
  def walk
    "I'm walking here."    
  end
end

module Swimmable
  def swim
    "I'm swimming here."
  end
end

module Climbable
  def climb
    "I'm climbing here."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---Animal method lookup---"
puts Animal.ancestors

fido = Animal.new
puts fido.speak
puts fido.walk
# puts fido.swim
puts GoodDog.ancestors

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_out_of_place_method(num)
    num ** 2
  end

end

buddy = Mammal::Dog.new
kitty = Mammal::Cat.new

buddy.speak("Woof")
kitty.say_name("kitty")
p value = Mammal.some_out_of_place_method(4)
p value2 = Mammal::some_out_of_place_method(5)