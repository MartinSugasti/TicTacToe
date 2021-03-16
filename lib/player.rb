class Player
  @identifiers = []

  class << self
    attr_accessor :identifiers

    def reset_identifiers
      Player.identifiers = []
    end
  end

  attr_reader :name, :identifier

  def initialize; end

  def identify
    puts "What's player #{Player.identifiers.length + 1} name?"
    @name = gets.chomp
    choose_identifier
  end

  def choose_identifier
    loop do
      puts 'Choose an identifier:'
      @identifier = gets.chomp

      break if identifier_available? && identifier_is_valid?
    end

    Player.identifiers.push(@identifier)
  end

  def identifier_available?
    return true unless Player.identifiers.include? @identifier

    puts "#{@identifier} was already choosen as identifier."
  end

  def identifier_is_valid?
    if identifier.length != 1
      puts 'Identifier must has exactly one character.'
    elsif identifier.to_i.to_s == identifier
      puts 'Identifier can\'t be a number.'
    elsif identifier.strip.empty?
      puts 'Identifier can\'t be an empty string.'
    else
      true
    end
  end
end
