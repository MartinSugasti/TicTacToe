require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @player_one = Player.new.identify
    @player_two = Player.new.identify
    @board = Board.new(@player_one.identifier, @player_two.identifier)
  end

  def play
    play_turn until game_over?
    print_result
    Player.reset_identifiers
  end

  private

  def game_over?
    @board.game_over?
  end

  def play_turn
    [@player_one, @player_two].each do |player|
      play_single_turn(player)
      break if game_over?
    end
  end

  def play_single_turn(player)
    loop do
      @board.print_board
      puts "#{player.name}, take an available location to place your identifier #{player.identifier}:"
      location = gets.chomp
      next unless @board.valid_location?(location)

      @board.take_location(location, player.identifier)
      break
    end
  end

  def print_result
    winner_identifier = @board.winner

    winner_identifier ? print_winner(winner_identifier) : print_draw
  end

  def print_draw
    puts 'It\'s a draw!'
  end

  def print_winner(identifier)
    winner = identifier == @player_one.identifier ? @player_one : @player_two
    puts "#{winner.name} is the winner!"
  end
end
