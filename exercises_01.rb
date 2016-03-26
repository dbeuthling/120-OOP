module Activity
  def activity(period)
    puts "You have #{period}."
   end
end

class Camper
  include Activity
end



bill = Camper.new
bill.activity("crafts")
puts ""
puts Camper.ancestors