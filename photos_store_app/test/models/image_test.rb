require "test_helper"

class ImageTest < ActiveSupport::TestCase
  test "should belong to imageable polymorphic" do
    assoc = Image.reflect_on_association(:imageable)
    assert_equal :belongs_to, assoc.macro
    assert_equal true, assoc.options[:polymorphic]
  end

  test "can associate with a variant" do
    product = Product.create!(id: "lego", name: "Lego")
    variant = Variant.create!(id: "lego_city", product: product, name: "Lego City")

    image = Image.create!(id: "lego_city_image", imageable: variant)

    # Check association
    assert_equal variant, image.imageable

    assert_includes variant.images, image
  end

  test "can associate with a product" do
    product = Product.create!(id: "lego", name: "Lego")

    image = Image.create!(id: "lego_logo_image", imageable: product)
    
    assert_equal product, image.imageable
    
    assert_includes product.images, image
  end
end
