# class Vehicle
#   attr_accessor :color
#   attr_reader :year, :model

#   @@vehicles = 0

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#     @@vehicles += 1
#   end

#   def speed_up(num)
#     @speed += num
#     puts "You are now going #{@speed} mph."
#   end

#   def brake(num)
#     @speed -= num
#     puts "You are now going #{@speed} mph."
#   end

#   def shut_off
#     @speed = 0
#     puts "You are now going #{@speed} mph."
#   end

#   def spray_paint(str)
#     self.color = str
#     puts "Your #{self.model} is now #{self.color}"
#   end

#   def number_of_vehicles
#     puts "You have created #{@@vehicles} vehicles."
#   end

#   def self.gas_milage(miles, gallons)
#     milage = miles / gallons
#     puts "#{milage} miles to the gallon"
#   end

#   def to_s
#     "You have a #{color} #{model} from #{year}"
#   end

#   def age
#     calc_age
#   end

#   private

#   def calc_age
#     Time.now.year - self.year
#   end

# end


# class MyCar < Vehicle
#   WHEELS = 4
#   PASSENGERS = 4
# end

# module HaulCapacity

#   def can_haul(pounds)
#     puts "Can carry #{pounds} pounds."
#   end

# end
# class MyTruck < Vehicle
#   include HaulCapacity
#   WHEELS = 6
#   PASSENGERS = 2
# end

# car = MyCar.new(1923, 'blue', 'ford')
# car.speed_up(45)
# car.color = 'blue'
# p car.color
# car.spray_paint('red')
# p car.year
# MyCar.gas_milage(700, 20)
# puts car
# truck = MyTruck.new(1987, 'red', 'chevy')
# car.number_of_vehicles
# truck.can_haul(450)
# p MyTruck.ancestors
# p MyCar.ancestors
# p Vehicle.ancestors
# p car.age
# p truck.age

# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(student)
#     student.grade < grade
#   end

#   protected

#   def grade
#     @grade
#   end
# end

# joe = Student.new('Joe', 89)
# bob = Student.new('Bob', 75)
# puts "Well done!" if joe.better_grade_than?(bob)
# p joe.grade

class Person
  @@people_count = 0
  attr_accessor :first_name, :last_name
  def initialize(first = '', last = '')
    @first_name = first
    @last_name = last
    @@people_count += 1
  end

  def self.people_count
    puts "#{@@people_count} instance(s) of Person class have been created."
  end

  def name
    @last_name == '' ? @first_name : @first_name + " " + @last_name
  end

  def name=(str)
    @first_name = str.split.first
    @last_name = str.split.last
  end
end

bob = Person.new('Robert')
p bob.name
p bob.first_name
p bob.last_name
bob.last_name = 'Smith'
p bob.name

bob.name = "John Adams"
p bob.name
p bob.first_name
p bob.last_name
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p rob == bob
p rob.name == bob.name
Person.people_count