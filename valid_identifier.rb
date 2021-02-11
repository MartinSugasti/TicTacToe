module ValidIdentifier
  def identifier_is_valid?(identifier)
    if identifier.is_a?(String) == false
      puts 'Identifier must be a string.'
      false
    elsif identifier.length != 1
      puts 'Identifier must have exactly one character.'
      false
    elsif identifier.to_i.to_s == identifier
      puts 'Identifier can\'t be a number.'
      false
    elsif identifier == ' '
      puts 'Identifier can\'t be an empty string.'
      false
    else
      true
    end
  end
end
