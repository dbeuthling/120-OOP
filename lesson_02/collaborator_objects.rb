class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Pet

  def speak
    'meow!'
  end
end

class Dog < Pet

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Bulldog < Dog

  def swim
    'can\'t swim!'
  end
end

class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new             # assume Bulldog class from previous assignment

p bob.pet = bud
p bob.pet.class