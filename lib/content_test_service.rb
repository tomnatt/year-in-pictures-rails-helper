class ContentTestService
  def self.run_tests(picture)
    { 'Title has no ending full stop' => no_ending_fullstop(picture.image_title),
      'Caption has no ending full stop' => no_ending_fullstop(picture.caption) }
  end

  def self.no_ending_fullstop(text)
    # No ending fullstop if last character is not a .
    return true if text[-1] != '.'

    # If last character is a ., not a fullstop if last 3 characters are ...
    return true if text[-3, 3] == '...'

    # Otherwise last character is a .
    false
  end

  def self.ellipsis_are_three_dots(text)
    # If there are four or more dots together
    return false if text =~ /\.{4,}/

    # Otherwise all is fine
    true
  end

  def self.i_is_capitalised(text)
    # If there is a lower case I at the start or in the middle
    return false if text =~ /(\A|\s)i\s/

    # Otherwise all is fine
    true
  end

  # def self.ends_with_punctuation(text)
  #   false
  # end
end
