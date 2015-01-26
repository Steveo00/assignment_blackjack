SUITS = ["Hearts", "Diamonds", "Spades", "Clubs"]
CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

def calculate_total(hand)
  arr = hand.map{ |e| e[1] }
  
  hand_total = 0
  arr.each do | value |
    if value == "A"
      hand_total += 11
    elsif value.to_i == 0
      hand_total += 10
    else
      hand_total += value.to_i
    end     
  end

  arr.select{ |e| e == "A" }.count.times do
    hand_total -= 10 if hand_total > 21
  end
  hand_total
end

def player_turn(hand, deck, player)
  begin
    hand << deck.pop
    total = calculate_total(hand)
    puts "Hey #{player}, you have drawn #{hand.last} which gives you a total of #{total}"
    if total == 21
      puts "So you think you are off to the Bahamas #{player}, now that you are a winner!!"  
      return deck, total
    end
    if total > 21
      puts "Sorry #{player}, you busted! Dealer wins"
      return deck, total
    end
    puts "What would you like to do #{player}? Enter 1 to hit or 2 to stay"
    hit_or_stay = gets.chomp.to_i
    return deck, total if hit_or_stay == 2
  end until total > 20
  return deck, total  
end

def dealer_turn(hand, deck, player)
  begin
    hand << deck.pop
    total = calculate_total(hand)
    puts "Dealer has drawn #{hand.last} which gives the Dealer a total of #{total}"
    if total == 21
      puts "Sorry #{player}, Dealer wins"
      return deck, total
    end
    if total > 21
      puts "Hey #{player}, the Dealer busted, you win !!"
      return deck, total
    end
  end until total > 16
  return deck, total  
end

continue = "y"

puts "\n"
puts "Welcome to Blackjack - are you ready to lose your shirt!!"
puts "\n"
puts "What is your name, or do I just call you sucker?"
player_name = gets.chomp
puts "\n"

while continue == "y"
puts "Are you ready #{player_name}?"
puts "\n"

continue = ""
hit_or_stay = ""

deck = SUITS.product(CARDS)
deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

dealer_total = calculate_total(dealer_cards)
player_total = calculate_total(player_cards)

puts "Dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}, for a total of #{dealer_total}"
puts "#{player_name} has: #{player_cards[0]} and #{player_cards[1]}, for a total of #{player_total}"
puts "\n"

puts "So you think you are off to the Bahamas #{player_name}, now that you are a winner!!" if player_total == 21
puts "Bad luck #{player_name}, Dealer dealt himself Blackjack - you lose!!" if dealer_total == 21

if player_total < 21 && dealer_total < 21 
  begin
    while !(hit_or_stay == 1 || hit_or_stay == 2) 
      puts "What would you like to do #{player_name}? Enter 1 to hit or 2 to stay"
      hit_or_stay = gets.chomp.to_i 
    end
    deck, player_total = player_turn(player_cards, deck, player_name) if hit_or_stay == 1
    if player_total < 21 
      begin
        deck, dealer_total = dealer_turn(dealer_cards, deck, player_name) if dealer_total < 17
        if dealer_total < 21
          begin
            puts "Bad luck #{player_name}, Dealer wins" if player_total <= dealer_total
            puts "Winners are grinners, #{player_name}" if dealer_total < player_total 
          end
        end  
      end
    end    
  end
end  

while !(continue == "y" || continue == "n")
  puts "Are you feeling lucky #{player_name}? Do you want to play again (y/n):"
  continue = gets.chomp.downcase
end
end
