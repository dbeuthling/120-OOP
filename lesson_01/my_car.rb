class Vehicle

  attr_accessor :color
  attr_reader :year
  attr_reader :model

  @@total_vehicles = 0

  def initialize(y, c, m)
    @speed = 0
    @year = y
    @color = c
    @model = m
    @@total_vehicles += 1
  end

  def park
    @speed = 0
    puts "You are parked."
  end

  def speed_up(num)
    @speed += num
    puts "Speeding up..."
    puts "Now travelling at #{@speed} MPH."
  end

  def brake(num)
    @speed -= num
    puts "Braking..."
    puts "Now travelling at #{@speed} MPH."
  end
  
  def info
    puts "The #{@model} is a #{@year} colored #{@color}, and is going #{@speed} mph."
    age
  end

  def spray_paint
    puts "What color would you like to paint the car?"
    @color = gets.chomp
    puts "The #{@model} is now #{@color}."
  end

  def self.gas_milage(gallons, miles)
    puts "You got #{miles / gallons} miles per gallon."
  end

  def to_s
    "The #{@model} is a #{@year} colored #{@color}, and is going #{@speed} mph."
  end

  def self.total_vehicles
    puts "A total of #{@@total_vehicles} vehicles have been initialized."
  end

  private
  def age
    puts "The #{model} is #{Time.now.year - @year} years old."
  end

end

module Towable
  def towing_capacity(lbs)
    puts "This #{model} can tow #{towing_capacity} lbs."
  end  
end


class MyCar < Vehicle
  PASSENGERS = 4
end

class MyTruck < Vehicle
  include Towable
  PASSENGERS = 2
end



honda = MyCar.new(2008, "gray", "element")
toyota = MyTruck.new(2015, "silver", "tundra")
honda.info
toyota.info
Vehicle.total_vehicles
puts "---MyCar Lookup---"
puts MyCar.ancestors
puts "---MyTruck Lookup---"
puts MyTruck.ancestors
puts "---Vehicle Lookup---"
puts Vehicle.ancestors
toyota.info
honda.info


class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(name)
    name.grade < grade
  end

  def name
    @name
  end

  protected
  def grade
    @grade
  end

  
end

joe = Student.new("joe", 98)
bob = Student.new("bob", 87)
puts joe.name
# puts bob.grade
puts "Well done!" if joe.better_grade_than?(bob)


