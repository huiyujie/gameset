class Card

  ATTRIBUTES = {
      :numbers => [1,2,3],
      :symbols =>[:diamond, :heart, :spade],
      :shadings => [:solid, :striped, :open],
      :colors => [:red, :green, :blue]
  }

  def self.attributes
    self::ATTRIBUTES
  end

  def initialize(number, symbol, shading, color)
    @number, @symbol, @shading, @color = number, symbol, shading, color
  end

  attr_accessor :number, :symbol, :shading, :color
  def to_s
    "number:#{@number}  symbol:#{@symbol}  shading:#{@shading}  color:#{@color}"
  end
  def to_pretty_s

    if @symbol == :diamond
      symbol = "\u2666"
    elsif @symbol == :heart
      symbol = "\u2665"
    else
      symbol = "\u2660"
    end

    color = 1
    if @color == :red
      color = 31
    elsif @color == :green
      color = 32
    elsif @color == :blue
      color = 34
    end

    if @shading == :open
      shading = "\u2b1c"
    elsif @shading == :solid
      shading = "\u2b1b"
    else
      shading = "\u3013"
    end

    symbol_string = ""
    @number.times do |i|
      symbol_string+=symbol
    end

    "\033[#{color}m #{shading.encode('utf-8')}  #{symbol_string.encode('utf-8')}\033[0m\n"
  end

end