class Rock

  def initialize
    @other_choice = 'scissors'
    
  end

  def winner?
    if @other_choice == 'scissors'
      return true
    end
    false
  end

end

x = Rock.new
p x.winner?