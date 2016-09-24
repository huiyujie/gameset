def checker(card1 , card2 , card3)
  isValid = true
  while card1.length > 0 && isValid
    value1, value2, value3 = card1[0], card2[0], card3[0]
    card1[0], card2[0], card3[0] = '', '', ''
    if value1 == value2 && value1 == value3 && value2 == value3
      isValid = true
    elsif (value1.to_i + value2.to_i + value3.to_i) == 3
      isValid =true
    else
      isValid = false
    end
  end
  return isValid
end
