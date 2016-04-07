#1
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0 # don't need @balance because attr_reader creates balance method
                 # that returns @balance
  end
end

#2 & #3
class InvoiceEntry
  attr_reader :quantity, :product_name
  attr_accessor :quantity, :product_name
  # attr_accessor means you could change the value by using pen.quantity = 45
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
    # need @quantity because you are setting the value not just reading it
  end

  def up
    puts @quantity
  end
end

# pen = InvoiceEntry.new('pen', 10)
# pen.up
# pen.update_quantity(20)
# pen.up
# pen.quantity = 45
# pen.up

#4
class Greeting
  def greet(salutation)
    puts salutation
  end

end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# hi = Greeting.new
# hi.greet('Hola!')

# p Hello.new.hi
# p Goodbye.new.bye

#5
class KrispyKreme
  def initialize(filling_type="plain", glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    # response = case
    # when @filling_type == nil && @glazing == nil
    #   "Plain"
    # when @filling_type != nil && @glazing == nil
    #   @filling_type
    # when @filling_type == nil && @glazing != nil
    #   "Plain with #{@glazing}."
    # else
    #   "#{@filling_type} with #{@glazing}."
    # end
    # response
    filling = @filling_type ? @filling_type : "Plain"
    glaze = @glazing ? " with #{@glazing}." : ''
    filling + glaze
  end

end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
puts donut2
puts donut3
puts donut4
puts donut5

#6
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer2
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

comp = Computer.new
comp.create_template
p comp.show_template

comp2 = Computer2.new
comp2.create_template
p comp2.show_template

#7
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  # def self.light_information
  def self.information
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end