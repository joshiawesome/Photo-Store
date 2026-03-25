# test/controllers/photos_controller_test.rb
require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    VariantAttribute.delete_all
    Image.delete_all
    Variant.delete_all
    AdditionalInformation.delete_all
    Product.delete_all
  end

  test "should get index with products and first image" do
    product = Product.create!(id: "lego", name: "lego")
    image = product.images.create!(id: 'lego_city', url: "https://example.com/lego_city.jpg")

    get photos_url, as: :json
    assert_response :success

    json = JSON.parse(response.body)
    # Find the product we created (fixtures also load products)
    # lego_product = json.find { |p| p["id"] == "lego" }
    assert_equal product.id, json.first["id"]
    assert_equal image.url, json.first["image"]
  end

  test "should call importer and return success message" do
    Photos::PhotosImporter.stub(:import, true) do
      post photos_import_url, as: :json
      assert_response :success

      json = JSON.parse(response.body)
      assert_equal "Photos imported successfully!", json["message"]
    end
  end
end