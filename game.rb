require_relative 'board'
require_relative 'player'

class Game
  def initialize; end

  def play
    board = Board.new
    player_one = Player.new('one')
    player_two = Player.new('two')
    winner_identifier = nil

    loop do
      [player_one, player_two].each do |player|
        loop do
          board.print_board
          puts "#{player.name}, take an available location to place your identifier #{player.identifier}:"
          location = gets.chomp
          break if board.change_cell(location, player.identifier)
        end

        winner_identifier = board.winner
        break if winner_identifier
      end

      break if winner_identifier
    end

    if winner_identifier.is_a?(Integer) && winner_identifier.zero?
      puts 'It\'s a draw!'
    else
      winner = winner_identifier == player_one.identifier ? player_one : player_two
      puts "#{winner.name} is the winner!"
    end

    Player.reset_identifiers
  end
end
