# test/controllers/products_controller_test.rb
require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    VariantAttribute.delete_all
    Image.delete_all
    Variant.delete_all
    AdditionalInformation.delete_all
    Product.delete_all
  end

  test "should call importer and return success message" do
    Products::ProductsImporter.stub(:import, true) do
      post products_import_url, as: :json
      assert_response :success

      json = JSON.parse(response.body)
      assert_equal "Products imported successfully!", json["message"]
    end
  end

  test "GET index responds with HTML" do
    get products_url # default format is HTML
    assert_response :success
    assert_match /<!DOCTYPE html>/, @response.body # crude check that HTML is rendered
  end

  test "should get index with products and first image" do
    product = Product.create!(id: "lego", name: "lego")
    variant = product.variants.create!(id: "lego_city_variant", name: "Lego City")
    image = variant.images.create!(id: 'lego_city_image', url: "https://example.com/lego_city.jpg")

    get products_url, as: :json
    assert_response :success

    json = JSON.parse(response.body)
    # Find the product we created (fixtures also load products)
    # lego_product = json.find { |p| p["id"] == "lego" }
    assert_equal product.id, json.first["id"]
    assert_equal image.url, json.first["image"]
  end

  test "should search products by name" do
    Product.__elasticsearch__.create_index!(force: true)

    product_one = Product.create!(id: "lego", name: "lego")
    product_two = Product.create!(id: "lego2", name: "lego2")

    Product.import
    Product.__elasticsearch__.refresh_index!

    get products_search_url, params: { query: "l" }, as: :json
    assert_response :success

    # expected_products = [product_one, product_two].map { |p| { id: p.id, name: p.name } }
    expected_products = [product_one, product_two].map { |p| { "id" => p.id, "name" => p.name } }

    json = JSON.parse(response.body)
    assert_equal expected_products, json
  end

  test "search_by_name returns empty array when no results" do
    Product.__elasticsearch__.create_index!(force: true)
      
    Product.create!(id: 'lego_city', name: "Lego City")
    Product.create!(id: 'lego_creator', name: "Lego Creator")

    Product.import
    Product.__elasticsearch__.refresh_index!

    results = Product.search_by_name("xyz").records.to_a

    assert_empty results
  end 

    test "should filter products by name" do
    Product.__elasticsearch__.create_index!(force: true)
      
    Product.create!(id: 'lego_city', name: "Lego City")
    Product.create!(id: 'lego_creator', name: "Lego Creator")

    Product.import
    Product.__elasticsearch__.refresh_index!

    results = Product.search_by_name("lego").records.to_a

    ids = results.map(&:id)
    assert_includes ids, "lego_city"
    assert_includes ids, "lego_creator"
  end

  test "filtering by name returns empty results when no matches are found" do
    Product.__elasticsearch__.create_index!(force: true)
      
    Product.create!(id: 'lego_city', name: "Lego City")
    Product.create!(id: 'lego_creator', name: "Lego Creator")

    Product.import
    Product.__elasticsearch__.refresh_index!

    results = Product.search_by_name("xyz").records.to_a

    ids = results.map(&:id)
    assert_empty ids
  end

  test "filtering by blank name string should return all products" do
    Product.__elasticsearch__.create_index!(force: true)
      
    Product.create!(id: 'lego_city', name: "Lego City")
    Product.create!(id: 'lego_creator', name: "Lego Creator")

    Product.import
    Product.__elasticsearch__.refresh_index!

    results = Product.search_by_name("").records.to_a

    ids = results.map(&:id)
    assert_includes ids, "lego_city"
    assert_includes ids, "lego_creator"
  end
end