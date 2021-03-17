class Board
  WINNER_CONFIGURATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                           [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  attr_accessor :selections, :locations

  def initialize(first_identifier, second_identifier)
    @selections = { first_identifier => [], second_identifier => [] }
    @locations = (1..9).to_a
  end

  def game_over?
    winner || draw?
  end

  def print_board
    puts "           #{print(1)} | #{print(2)} | #{print(3)}  "
    puts '          ---+---+---'
    puts "           #{print(4)} | #{print(5)} | #{print(6)}  "
    puts '          ---+---+---'
    puts "           #{print(7)} | #{print(8)} | #{print(9)}  \n\n"
  end

  def winner
    @selections.each do |identifier, locations|
      WINNER_CONFIGURATIONS.each do |winner_configuration|
        return identifier if (winner_configuration - locations).empty?
      end
    end

    false
  end

  def draw?
    @locations.empty?
  end

  def valid_location?(location)
    if @locations.include?(location.to_i)
      true
    elsif (1..9).to_a.include?(location.to_i)
      puts 'That place is already taken.'
    else
      puts 'Location not found.'
    end
  end

  def take_location(location, identifier)
    @selections[identifier] << location.to_i
    @locations.delete(location.to_i)
  end

  def print(location)
    if @locations.include? location
      location
    else
      @selections.find { |_, value| value.include? location }.first
    end
  end
end
