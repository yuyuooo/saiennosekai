require "test_helper"

class CropFoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crop_folders_index_url
    assert_response :success
  end

  test "should get show" do
    get crop_folders_show_url
    assert_response :success
  end
end
