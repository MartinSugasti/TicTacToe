class Player
  attr_reader :name, :identifier

  @@identifiers = []

  def initialize
    puts "What's player #{@@identifiers.length + 1} name?"
    @name = gets.chomp
    choose_identifier
  end

  def self.reset_identifiers
    @@identifiers = []
  end

  private

  def choose_identifier
    loop do
      puts 'Choose an identifier:'
      @identifier = gets.chomp

      break if identifier_available? && identifier_is_valid?
    end

    @@identifiers.push(@identifier)
  end

  def identifier_available?
    return true unless @@identifiers.include? @identifier

    puts "#{@identifier} was already choosen as identifier."
  end

  def identifier_is_valid?
    if identifier.length != 1
      puts 'Identifier must have exactly one character.'
    elsif identifier.to_i.to_s == identifier
      puts 'Identifier can\'t be a number.'
    elsif identifier.empty?
      puts 'Identifier can\'t be an empty string.'
    else
      true
    end
  end
end
