require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  setup do
    @placeholder_picture = Picture.placeholder('TestOne')
  end

  test 'correct image filename' do
    expected_filename = "#{get_month(@placeholder_picture.month)}-testone.png"
    assert_equal expected_filename, @placeholder_picture.image, 'Incorrectly generated image filename'
  end

  test 'placeholder with invalid user' do
    pic = Picture.placeholder('InvalidUser')
    assert_equal 'Placeholder', pic.image_title, 'Image title should have been Placeholder'
    assert_equal 'Placeholder', pic.caption, 'Image caption should have been Placeholder'
    assert_equal 'Placeholder', pic.description, 'Image description should have been Placeholder'
    assert_equal 'Placeholder', pic.alt, 'Image alt should have been Placeholder'
    assert_equal 'Placeholder', pic.image_title, 'Image title should have been Placeholder'

    expected_filename = "#{get_month(pic.month)}-invaliduser.png"
    assert_equal expected_filename, pic.image, 'Image filename was incorrect'
  end

  test 'correct output format' do
    expected_output = <<OUTPUT
  -
    image: #{get_month(@placeholder_picture.month)}-testone.png
    image_title: "Placeholder"
    caption: "Placeholder"
    description: "Placeholder"
    alt: "Placeholder"
    month: #{Date::MONTHNAMES[@placeholder_picture.month].downcase}
OUTPUT

    assert_equal expected_output, @placeholder_picture.yaml_output, 'YAML output has changed'
  end

  test 'correct default date for early Feb' do
    travel_to Time.new(2018, 2, 2)
    pic = Picture.new
    assert_equal 1, pic.month
    assert_equal 2018, pic.year
  end

  test 'correct name for image file for single named user' do
    pic = Picture.placeholder(users(:single_name_user).fullname)
    expected_filename = "#{get_month(pic.month)}-craig.png"
    assert_equal expected_filename, pic.image, 'Generated filename does not match expected filename'
  end

  test 'correct name for image file for multi-named user' do
    pic = Picture.placeholder(users(:multi_name_user).fullname)
    expected_filename = "#{get_month(pic.month)}-tom-jerry.png"
    assert_equal expected_filename, pic.image, 'Generated filename does not match expected filename'
  end

  test 'correct name for image file for forename surname user' do
    pic = Picture.placeholder(users(:two_name_user).fullname)
    expected_filename = "#{get_month(pic.month)}-angry_wiggleforth.png"
    assert_equal expected_filename, pic.image, 'Generated filename does not match expected filename'
  end

  test 'strip leading and trailing whitespace on save' do
    pic = pictures(:whitespace_to_strip)
    assert leading_trailing_whitespace?(pic.image_title), 'Picture should have whitespace in title'
    assert leading_trailing_whitespace?(pic.caption), 'Picture should have whitespace in caption'
    assert leading_trailing_whitespace?(pic.description), 'Picture should have whitespace in description'
    assert leading_trailing_whitespace?(pic.alt), 'Picture should have whitespace in alt'

    # Save and re-fetch picture
    pic.save
    pic = users(:whitespace_user).pictures.take

    refute leading_trailing_whitespace?(pic.image_title), 'Picture should not have whitespace in title'
    refute leading_trailing_whitespace?(pic.caption), 'Picture should not have whitespace in caption'
    refute leading_trailing_whitespace?(pic.description), 'Picture should not have whitespace in description'
    refute leading_trailing_whitespace?(pic.alt), 'Picture should not have whitespace in alt'
  end

  # Prefix the month with a 0 if it's single digit
  def get_month(month)
    month = month.to_s
    month.length == 2 ? month : "0#{month}"
  end

  # Compares a string with its stripped version (not efficient)
  def leading_trailing_whitespace?(str)
    str != str.strip
  end
end
