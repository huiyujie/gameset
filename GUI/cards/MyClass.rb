class MyClass

  include GladeGUI
  load 'check.rb'
  def initialize()
    # Store the cards you chose
    @@ClickedCards = []
    # Store the button clicked	
    @@ClickedButtons = []

    @@allcards = ["0000","0001","0002","0010","0011","0012","0020", "0021",
                  "0022","0100","0101","0102","0110","0111","0112",
                  "0120","0121","0122","0200","0201","0202","0210","0211",
                  "0212","0220","0221","0222","1000","1001","1002","1010",
                  "1011","1012","1020","1021","1022","1100","1101","1102",
                  "1110","1111","1112","1120","1121","1122","1200","1201",
                  "1202","1210","1211","1212","1220","1221","1222","2000",
                  "2001","2002","2010","2011","2012","2020","2021","2022",
                  "2100","2101","2102","2110","2111","2112","2120","2121",
                  "2122","2200","2201","2202","2210","2211","2212","2220",
                  "2221","2222"]
    @score = {"button16" => 0 , "button17" => 0 , "button18" => 0 , "button19" => 0}
  end

  def before_show()
    @path = File.dirname(__FILE__) + '/'
    setimages
  end

  def setimages
    @@allcards = @@allcards.shuffle
    #put 12cards on the table
    @@table = @@allcards[0,12]
    @@allcards -= @@table

    @image1 = @path + @@table[0] + ".jpg"
    @image2 = @path + @@table[1] + ".jpg"
    @image3 = @path + @@table[2] + ".jpg"
    @image4 = @path + @@table[3] + ".jpg"
    @image5 = @path + @@table[4] + ".jpg"
    @image6 = @path + @@table[5] + ".jpg"
    @image7 = @path + @@table[6] + ".jpg"
    @image8 = @path + @@table[7] + ".jpg"
    @image9 = @path + @@table[8] + ".jpg"
    @image10 = @path + @@table[9] + ".jpg"
    @image11 = @path + @@table[10] + ".jpg"
    @image12 = @path + @@table[11] + ".jpg"
    @image13 = @path + "set.jpg"
    set_glade_all()
  end


  def button13__clicked(*args)

    @@ClickedButtons.each {|x| x.sesnsitive = true}

    setimages
  end

  def button14__clicked(*args)

    exit!(0)
  end

   def button16__clicked(*args)
     if @@ClickedButtons.length == 3
       @@ClickedButtons.push('button16')
       puts(@@ClickedButtons)
     end
     setOrNot
   end

  def button17__clicked(*args)
    if @@ClickedButtons.length == 3
      @@ClickedButtons.push('button17')
    end
    setOrNot
  end

  def button18__clicked(*args)
    if @@ClickedButtons.length == 3
      @@ClickedButtons.push('button18')
    end
    setOrNot
  end

  def button19__clicked(*args)
    if @@ClickedButtons.length == 3
      @@ClickedButtons.push('button19')
    end
    setOrNot
  end

  def button__clicked(*args)
    if @@ClickedButtons.length > 3
      file_name = args[0].image.file
      file_name.slice! @path
      file_name.slice! ".jpg"
      args[0].sensitive = false
      if !@@ClickedCards.include? file_name
        @@ClickedCards.push(file_name)
        @@ClickedButtons.push(args[0])
      end
    end
  end
# when choose 3 cards check if they are a set or not
  def setOrNot
    if @@ClickedButtons.length == 4
      if checker(@@ClickedCards[0], @@ClickedCards[1], @@ClickedCards[2])
        @builder['button15'].label = 'It is a set!'
        player = @@ClickedButtons[3]
        @score[player] += 1
        id = player.scan(/\d/)
        id = (id[0] + id[1]).to_i - 15
        @builder[player].label = "player" + id.to_s + "\n " + @score[player].to_s
        addCards
      else
        @builder["button15"].label = "Not a set!"
        @@ClickedButtons.pop()
        @@ClickedButtons.each {|x| x.sensitive = true}
      end
      @@ClickedButtons = []
      @@ClickedCards = []
    end
  end
# If they are a set add three new cards
  def addCards
    if @@allcards.length >= 3
      newCards = @@allcards[0,3]
      @@allcards -= newCards
      @@table -= @@ClickedCards
      @@table += newCards
      @@ClickedButtons.pop()
      @@ClickedButtons.each {|x| x.sensitive = true}
      @@ClickedButtons.each_with_index {|x , index| x.image.file = @path +
          newCards[index] + ".jpg"}
    end

    if @@allcards.length == 0
      exit!(0)
    end
  end


end
