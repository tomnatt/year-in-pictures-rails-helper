require 'test_helper'

class PictureSubmitTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'admin can submit picture' do
    submission_for users(:admin_user)
  end

  test 'non-admin can submit picture' do
    submission_for users(:normal_user)
  end

  test 'admin can update picture' do
    update_for users(:admin_user), pictures(:admin_user_to_edit)
  end

  test 'non-admin can update picture' do
    update_for users(:normal_user), pictures(:normal_user_to_edit)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def submission_for(user)
    sign_in user
    initial_picture_count = Picture.count

    # Start on the index page, click through to add a new picture and check we're in the right place
    visit pictures_path
    click_on 'add-picture'
    assert_equal new_picture_path, page.current_path, 'We should be on the new picture page'

    # Fill in the form and click save
    fill_in 'picture_caption', with: 'Caption'
    fill_in 'picture_image_title', with: 'Image title'
    fill_in 'picture_description', with: 'Description'
    fill_in 'picture_alt', with: 'Alt'
    click_on 'Save my image'

    # Check the picture has saved and page contents are correct
    assert page.has_content?('Picture was successfully created.'), 'Picture was not successfully submitted'
    assert_equal initial_picture_count + 1, Picture.count, 'Total picture count has not increased by one'
    assert page.has_content?('image_title: "Image title"')
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def update_for(user, picture)
    sign_in user
    initial_picture_count = Picture.count
    new_title = "New title for #{user.fullname.downcase}"

    # Find the right picture and click to edit screen
    visit pictures_path(year: picture.year)
    page.first(:css, "a[href=\"#{edit_picture_path(id: picture.id)}\"]").click
    assert_equal edit_picture_path(id: picture.id), page.current_path, 'We are on the wrong page'

    # Update it and capture old title
    old_title = page.first(:css, '#picture_image_title').value
    fill_in 'picture_image_title', with: new_title
    click_on 'Save my image'

    # Check the picture has saved and page contents are correct
    assert page.has_content?('Picture was successfully updated.'), 'Picture was not successfully updated'
    assert_equal initial_picture_count, Picture.count, 'Total picture count should not have changed'
    assert page.has_content?('caption: "Caption for update check"')
    refute page.has_content?("image_title: \"#{old_title}\"")
    assert page.has_content?("image_title: \"#{new_title}\"")
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
