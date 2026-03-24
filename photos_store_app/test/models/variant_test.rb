require "test_helper"

class VariantTest < ActiveSupport::TestCase
  test "belongs to product association definition" do
    assoc = Variant.reflect_on_association(:product)
    assert_equal :belongs_to, assoc.macro
  end
  
  test "has many images association definition" do
    assoc = Variant.reflect_on_association(:images)
    assert_equal :has_many, assoc.macro
    assert_equal :imageable, assoc.options[:as]
  end
  
  test "has one variant attribute association definition" do
    assoc = Variant.reflect_on_association(:variant_attribute)
    assert_equal :has_one, assoc.macro
  end

  test "belongs to one product in practice" do
    product = Product.create!(id: 'lego', name:'Lego')
    variant = Variant.create!(id: 'lego_city', product: product, name:'Lego City')
    
    assert_equal product, variant.product
  end

  test "has many images in practice" do
    product = Product.create!(id: 'lego', name:'Lego')
    variant = Variant.create!(id: 'lego_city', product: product, name:'Lego City')
    
    lego_city_image = Image.create!(id: 'lego_city_image', imageable: variant, url: 'https://example.com/lego_city.jpg')
    lego_creator_image = Image.create!(id: 'lego_creator_image', imageable: variant, url: 'https://example.com/lego_creator.jpg')
    
    assert_equal 2, variant.images.count

    assert_includes variant.images, lego_city_image
    assert_includes variant.images, lego_creator_image
  end

  test "has one variant attribute in practice" do
    product = Product.create!(id: 'lego', name:'Lego')
    variant = Variant.create!(id: 'lego_city', product: product, name:'Lego City')
    
    variant_attribute = VariantAttribute.create!(variant: variant, color_swatch: 'matte black')
    
    assert_equal variant_attribute, variant.variant_attribute
  end
end
