require './board'
require './player'
class Game
  attr_accessor :pretty_print
  
  #initializes the game with a new board and players
  def initialize
    @board = Board.new
    @players = []
    @pretty_print = true

    puts 'Welcome to the Game of Set!'
    puts 'Please enter player names with a space separating each name.'

    input = gets.strip.split(' ')
    until input.uniq.count == input.count#we need unique names
      puts 'Please enter unique player names.'
      input = gets.strip.split(' ')
    end
    input.each do |name|
      @players << Player.new(name)
    end
    print_players
    print_cards
  end

  #checks if the player entered set is correct
  def match_set(name, i1, i2, i3)
    if contains_player?(name)
      if @board.is_set?(i1, i2, i3)
        @board.remove_set(i1, i2, i3)
        puts 'Congrats! You found a set. The cards have been removed.'
        update_player(name)
        if @board.add_cards#if new cards have been added 
          puts 'New cards have been added.'
        else#if no new cards have been added, this means deck is empty and game is near end
          unless @board.find_set? #make sure there is at least 1 set, end game if there is not a possible set so players don't get stuck
            game_over
          end
        end
        print_cards
      else
        puts 'Those cards are not a set, please try again.'
      end
    else
      puts "Player name doesn't exist. Try again."
    end
  end
  
  #gets the number of cards on the board
  def card_count
    @board.card_count
  end

  #find a possible set, used mainly for debugging and cheating
  def find_set
    set = @board.find_set?
    if set
      puts "Cards ##{set} form a set.\n"
    else
      puts "There are no possible combination of cards which form a set.\n"
    end
  end
  
  #print all the cards on the board
  def print_cards
    puts '***Current Cards***'
    if @pretty_print
      @board.print_pretty_cards
    else
      @board.print_cards
    end
    puts "\nType 'set <player> <card_number1> <card_number2> <card_number3>' to select a set\n"
  end

  #print all the players in the game
  def print_players
    puts '***Current Players***'
    @players.each do |player|
      puts player.to_s
    end
  end 
  
  #check is the game contains a player
  def contains_player?(name)
    @players.any? do |player|
      player.name == name
    end
  end

  #updates the player's score if they find a set
  def update_player(name)
    temp = @players.find_all do |i|
      i.name == name
    end
    temp[0].score += 1 #this is okay because there is no dups

  end

  #gives a hint, which is only the first  2 numbers of a set
  def hint
    set = @board.find_set?
    if set
      puts "Cards #[#{set[0]}, #{set[1]}, X] form a set.\n"
    else
      puts "There are no possible combination of cards which form a set.\n"
    end
  end

  #prints the help message 
  def help
    puts 'There are 6 total commands you are enter in this game.'
    puts '1. The set command will allow a player to pick a set'
    puts 'set <player> <card_number1> <card_number2> <card_number3>'
    puts '2. The printcards command will print all the current cards on the board'
    puts 'printcards'
    puts '3. The printplayers command will print all the current players in the game'
    puts 'printplayers'
    puts '4. The findset command will provide a possible set of cards on the board'
    puts 'findset'
    puts '5. The hint command will provide two cards of a possible set of cards on the board'
    puts 'hint'
    puts '6. The prettyprint command will set pretty printing of cards on or off'
    puts 'prettyprint'
    puts '7. The help command will print this helpful message'
    puts 'help'
  end

  #handles the game over behavoir, and then exits the game
  def game_over
    unless @board.find_set?
      puts 'Game Over! No more possible sets on the board!'
      print_players
      winner = @players.max_by do |player|
        player.score
      end
      puts "Winner is #{winner}"
      puts 'Thanks for playing the Game of Set!'
      exit
    end
  end
end


game = Game.new
input = gets.chomp
until input == 'exit'
  case input

    when /set\s+([a-zA-Z0-9_]+)\s+(\d+)\s+(\d+)\s+(\d+)/#matches the string 'set <name> <id1> <id2> <id3>'
      nums = [Integer($2),Integer($3), Integer($4)]
      if nums.uniq.count == 3 && nums.max< game.card_count #makes sure the numbers are uniq and the max value is not array out of bounds
        puts "You choose cards #[#{$2}, #{$3}, #{$4}]."
        game.match_set($1, Integer($2), Integer($3), Integer($4))
      else
        puts "Please enter three unique cards numbers less than #{game.card_count}"
      end

    when /print\s*cards/
      game.print_cards
    when /print\s*players/
      game.print_players
    when /find\s*set/
      game.find_set
    when /hint/
      game.hint
    when /help/
      game.help
    when /pretty\s*print/
      if game.pretty_print
        puts 'Turning pretty print off'
      else
        puts 'Turning pretty print on'
      end
      game.pretty_print = !game.pretty_print
    else
      puts 'Please check your input again.'

  end
  input = gets.chomp
end



