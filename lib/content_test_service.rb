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
end
