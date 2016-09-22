require './deck.rb'
class Board
  INITIAL_CARDS_NUMBER = 12


  #intializes the board with a deck and 12 cards
  def initialize
    @deck = Deck.new
    @cards = []
    INITIAL_CARDS_NUMBER.times do
      @cards << @deck.show
    end

    until find_set?
      add_cards
    end
  end

  #checks if the three card indexes form a set
  def is_set? (i1, i2, i3)
    if ([@cards[i1].number, @cards[i2].number, @cards[i3].number].uniq.count == 1) || ([@cards[i1].number, @cards[i2].number, @cards[i3].number].uniq.count == 3)
      if ([@cards[i1].symbol, @cards[i2].symbol, @cards[i3].symbol].uniq.count == 1) || ([@cards[i1].symbol, @cards[i2].symbol, @cards[i3].symbol].uniq.count == 3)
        if ([@cards[i1].shading, @cards[i2].shading, @cards[i3].shading].uniq.count == 1) || ([@cards[i1].shading, @cards[i2].shading, @cards[i3].shading].uniq.count == 3)
          if ([@cards[i1].color, @cards[i2].color, @cards[i3].color].uniq.count == 1) || ([@cards[i1].color, @cards[i2].color, @cards[i3].color].uniq.count == 3)
            return true
          end
        end
      end
    end
    false
  end
  
  #finds a possible set on the board. Useful for hints and also cheats
  def find_set?
    (0...@cards.count).to_a.combination(3).to_a.each do |i|
      if is_set?(i[0], i[1], i[2])
        return i
      end
    end
    false
  end

  #remove three cards from the cards array 
  def remove_set (i1, i2, i3)
    @cards.delete_if.with_index { |_, index| [i1,i2,i3].include? index }
  end

  #add more cards to the board, return true if successfully added, false if not
  def add_cards
    return false if @deck.deck.count == 0
    3.times do
      @cards << @deck.show
    end
    until find_set? || @deck.deck.count == 0 #keep adding until there is a possible set, don't want players to be stuck
      add_cards
    end
    true
  end

  #gets the number of cards on the board
  def card_count
    @cards.count
  end

  #prints the cards in a normal, boring, ASCII only manner
  def print_cards
    @cards.each_index do |i|
      puts "##{i} #{@cards[i].to_s}"
    end
  end

  #prints the cards in a pretty way, but needs a supported terminal
  def print_pretty_cards
    @cards.each_index do |i|
      puts "##{i} #{@cards[i].to_pretty_s}"
    end
  end
end
