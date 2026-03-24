require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "has many variants association definition" do
    assoc = Product.reflect_on_association(:variants)
    assert_equal :has_many, assoc.macro
  end

  test "has many images association definition" do
    assoc = Product.reflect_on_association(:images)
    assert_equal :has_many, assoc.macro
  end

  test "has many additional_informations association definition" do
    assoc = Product.reflect_on_association(:additional_informations)
    assert_equal :has_many, assoc.macro
  end

  test "has many variants in practice" do
    product = Product.create!(id: 'lego', name:'Lego')

    # product: product -> sets product_id on variant
    
    Variant.create!(id: 'lego_city', product: product, name:'Lego City')
    Variant.create!(id: 'lego_creator', product: product, name:'Lego Creator')

    assert_equal 2, product.variants.count
  end


  test "has many images in practice" do
    product = Product.create!(id: 'lego', name:'Lego')

    Image.create!(id: 'lego_city_image', imageable: product, url:'https://example.com/lego_city.jpg')
    Image.create!(id: 'lego_creator_image', imageable: product, url:'https://example.com/lego_creator.jpg')

    assert_equal 2, product.images.count
  end

  test "has many additional_informations in practice" do
    product = Product.create!(id: 'lego', name:'Lego')

    AdditionalInformation.create!(product: product, title:'Lego City Instructions')
    AdditionalInformation.create!(product: product, title:'Lego Creator Instructions')

    assert_equal 2, product.additional_informations.count
  end
end
