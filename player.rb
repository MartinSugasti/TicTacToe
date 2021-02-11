require_relative 'valid_identifier'

class Player
  include ValidIdentifier

  attr_accessor :name, :identifier

  @@identifiers = []

  def initialize(number)
    puts "What's player #{number} name?"
    @name = gets.chomp
    identifier = nil

    loop do
      puts 'Choose an identifier:'
      identifier = gets.chomp

      break if identifier_available?(identifier) && identifier_is_valid?(identifier)
    end

    @identifier = identifier
    @@identifiers.push(@identifier)
  end

  def self.reset_identifiers
    @@identifiers = []
  end

  private

  def identifier_available?(identifier)
    return true unless @@identifiers.include? identifier

    puts "#{identifier} was already choosen as identifier."
    false
  end
end
