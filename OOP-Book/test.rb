class Mammal
  def initialize(name)
    @name = name
  end

  def proper
    "His name is #{capital_name}"
  end

  private

  def capital_name
    @name.capitalize
  end
end

me = Mammal.new('frank')
p me.proper
me.capital_name
