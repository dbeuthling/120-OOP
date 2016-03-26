class MyCar

  attr_accessor :color
  attr_reader :year

  def initialize(y, c, m, s=0)
    @year = y
    @color = c
    @model = m
    @speed = s
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

  def park
    @speed = 0
    puts "The #{@model} is parked."
  end

  def info
    puts "The #{@model} is a #{@year} colored #{@color}, and is going #{@speed} mph."
  end

  def spray_paint
    puts "What color would you like to paint the car?"
    @color = gets.chomp
    puts "The #{@model} is now #{@color}."
  end

end


honda = MyCar.new("2008", "gray", "element")
honda.info
honda.speed_up(65)
honda.info
honda.brake(15)
honda.info
honda.park
honda.info

p honda.color
p honda.year
honda.color = "pink"
p honda.color
honda.spray_paint
honda.info