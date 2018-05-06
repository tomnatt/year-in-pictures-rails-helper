require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  setup do
    @placeholder_picture = Picture.placeholder('test one')
  end

  test 'correct image filename' do
    expected_filename = "#{get_month(@placeholder_picture.month)}-testone.png"
    assert_equal expected_filename, @placeholder_picture.image, 'Incorrectly generated image filename'
  end

  test 'placeholder with invalid user' do
    pic = Picture.placeholder('invalid user')
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

  # Prefix the month with a 0 if it's single digit
  def get_month(month)
    month = month.to_s
    month.length == 2 ? month : "0#{month}"
  end
end
