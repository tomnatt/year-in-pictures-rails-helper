require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user_one)
    @picture = pictures(:dan_january)
  end

  test 'should get index' do
    get pictures_url
    assert_response :success
  end

  test 'should get new' do
    get new_picture_url
    assert_response :success
  end

  test 'should create picture' do
    assert_difference('Picture.count') do
      post pictures_url, params: { picture: {
        caption: @picture.caption,
        description: @picture.description,
        image: @picture.image,
        image_title: @picture.image_title,
        alt: @picture.alt,
        month: @picture.month,
        user_id: @picture.user.id,
        year: @picture.year
      } }
    end

    assert_redirected_to picture_url(Picture.last)
  end

  test 'should show picture' do
    get picture_url(@picture)
    assert_response :success
  end

  test 'should get edit' do
    get edit_picture_url(@picture)
    assert_response :success
  end

  test 'should update picture' do
    patch picture_url(@picture), params: { picture: {
      caption: @picture.caption,
      description: @picture.description,
      image: @picture.image,
      image_title: @picture.image_title,
      user_id: @picture.user.id,
      month: @picture.month,
      year: @picture.year
    } }
    assert_redirected_to picture_url(@picture)
  end

  test 'should destroy picture' do
    assert_difference('Picture.count', -1) do
      delete picture_url(@picture)
    end

    assert_redirected_to pictures_url
  end
end
