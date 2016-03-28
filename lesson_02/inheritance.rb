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

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
ralph = Bulldog.new
puts ralph.swim
puts ralph.speak
morgan = Cat.new
puts morgan.run
puts morgan.jump
puts morgan.speak
p Bulldog.ancestors

