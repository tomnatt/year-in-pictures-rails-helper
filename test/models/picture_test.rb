require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  setup do
    @placeholder_picture = Picture.placeholder('tom')
  end

  test 'correct number of photographers' do
    assert_equal 15, Picture.photographers.length, 'Wrong number of photographers'
  end

  test 'correct image filename' do
    expected_filename = "#{@placeholder_picture.month}-#{@placeholder_picture.photographer}.png"
    assert_equal expected_filename, @placeholder_picture.image, 'Incorrectly generated image filename'
  end

  test 'correct output format' do
    expected_output = <<OUTPUT
  -
    image: #{@placeholder_picture.month}-tom.png
    image_title:  "Placeholder"
    caption: "Placeholder"
    description: "Placeholder"
    alt: "Placeholder"
    month: #{Date::MONTHNAMES[@placeholder_picture.month].downcase}
OUTPUT

    assert_equal expected_output, @placeholder_picture.yaml_output, 'YAML output has changed'
  end
end
