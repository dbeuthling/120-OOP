# module Activity
#   def activity(period)
#     puts "You have #{period}."
#    end
# end

# class Camper
#   include Activity
# end



# bill = Camper.new
# bill.activity("crafts")
# puts ""
# puts Camper.ancestors



# class GoodDog
#   def initialize
#     puts " This object was initialized!"
#   end
# end

# sparky = GoodDog.new
# p sparky


class GoodDog

  attr_accessor :name, :height, :weight

  # def name
  #   @name
  # end

  # def name=(name)
  #   @name = name
  # end


  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = weight
  end

  def speak
    "#{name} says bow wow!"
  end

  # def speak
  #   "#{@name} says Arf!"
  # end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

end

sparky = GoodDog.new("Sparky", "12 inches", "10 pounds")
p sparky.speak

fido = GoodDog.new("Fido", "", "")
p fido.speak

p sparky.name
sparky.change_info("New-Sparky", "24 inches", "45 lbs")
p sparky.info
p GoodDog.what_am_i


