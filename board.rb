require_relative 'valid_identifier'

class Board
  include ValidIdentifier

  def initialize
    @cells = (1..9).to_a
    @locations = (1..9).to_a
  end

  def change_cell(location, identifier)
    if !identifier_is_valid?(identifier)
      false
    elsif location.to_i.to_s == location && location.to_i.is_a?(Integer) && @locations.include?(location.to_i)
      change_cell_private(location.to_i, identifier)
      true
    elsif location.to_i.to_s == location && location.to_i.is_a?(Integer) && (1..9).to_a.include?(location.to_i)
      puts 'That place is already taken.'
      false
    else
      puts 'Location not found.'
      false
    end
  end

  def winner
    if ((@cells[0] == @cells[4]) && (@cells[4] == @cells[8])) || ((@cells[3] == @cells[4]) && (@cells[4] == @cells[5])) || ((@cells[2] == @cells[4]) && (@cells[4] == @cells[6])) || ((@cells[1] == @cells[4]) && (@cells[4] == @cells[7]))
      @cells[4]
    elsif ((@cells[0] == @cells[1]) && (@cells[1] == @cells[2])) || ((@cells[0] == @cells[3]) && (@cells[3] == @cells[6]))
      @cells[0]
    elsif ((@cells[2] == @cells[5]) && (@cells[5] == @cells[8])) || ((@cells[6] == @cells[7]) && (@cells[7] == @cells[8]))
      @cells[8]
    elsif @locations.empty?
      0
    else
      false
    end
  end

  def print_board
    puts "           #{@cells[0]} | #{@cells[1]} | #{@cells[2]}  "
    puts '          ---+---+---'
    puts "           #{@cells[3]} | #{@cells[4]} | #{@cells[5]}  "
    puts '          ---+---+---'
    puts "           #{@cells[6]} | #{@cells[7]} | #{@cells[8]}  "
    puts '                                  '
  end

  private

  def change_cell_private(location, identifier)
    @cells[location - 1] = identifier

    @locations.delete(location)
  end
end
