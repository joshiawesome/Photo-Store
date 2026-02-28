require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index as html" do
    # this is equivalent to GET /photos
    get photos_url
    assert_response :success
  end

  test "should get index as json" do
    # as: :json is a Ruby Hash - translates to key: value
    get photos_url, as: :json
    assert_response :success
  end

  test "should import photos" do
    # stub the import method to return true
    # this is to prevent the import method from being called
    # tests for the impoter must be written separately
    Photos::PhotosImporter.stub(:import, true) do
      post photos_import_url

      assert_response :success
      json = JSON.parse(response.body)
      assert_equal "Photos imported successfully!", json["message"]
    end
  end
end
