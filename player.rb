class Player

  #initializes the player with a name. Score is defaulted to 0 unless you are JOHNCENA
  def initialize (name)
    @name = name
    @score = 0
    if name == 'JOHNCENA'
      @score = 9001
    end
  end

  attr_accessor :name, :score
  #prints the player info
  def to_s
    "Player: #{@name} Score: #{@score}"
  end
end
