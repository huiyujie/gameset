require './card.rb'
class Deck
  attr_accessor :deck

  #initializes the deck with each possible combination and randomizes
  def initialize
    @deck = []
    Card.attributes[:numbers].each do |number|
        Card.attributes[:symbols].each do |symbol|
          Card.attributes[:shadings].each do |shading|
            Card.attributes[:colors].each do |color|
              @deck << Card.new(number, symbol, shading, color)
            end
          end
        end
    end
    @deck.shuffle!
  end

  #removes a card from the deck and returns it. 
  def show
    @deck.pop
  end

end
