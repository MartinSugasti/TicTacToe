require_relative 'game'

play = true

while play
  Game.new.play
  puts "Would you like to play a new game? Press 'y' to start a new game!"
  play = gets.chomp == 'y'
  puts 'Have a nice day!' unless play
end
